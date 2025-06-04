;; Architect Verification Contract
;; Manages architect registration and verification

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_FOUND (err u102))
(define-constant ERR_INVALID_LICENSE (err u103))

;; Data structures
(define-map architects
  { architect: principal }
  {
    license-number: (string-ascii 50),
    name: (string-ascii 100),
    verified: bool,
    verification-date: uint,
    specializations: (list 10 (string-ascii 50))
  }
)

(define-map verification-requests
  { request-id: uint }
  {
    architect: principal,
    license-number: (string-ascii 50),
    name: (string-ascii 100),
    specializations: (list 10 (string-ascii 50)),
    status: (string-ascii 20)
  }
)

(define-data-var next-request-id uint u1)

;; Public functions
(define-public (request-verification
  (license-number (string-ascii 50))
  (name (string-ascii 100))
  (specializations (list 10 (string-ascii 50))))
  (let ((request-id (var-get next-request-id)))
    (map-set verification-requests
      { request-id: request-id }
      {
        architect: tx-sender,
        license-number: license-number,
        name: name,
        specializations: specializations,
        status: "pending"
      }
    )
    (var-set next-request-id (+ request-id u1))
    (ok request-id)
  )
)

(define-public (verify-architect (request-id uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (match (map-get? verification-requests { request-id: request-id })
      request-data
      (begin
        (map-set architects
          { architect: (get architect request-data) }
          {
            license-number: (get license-number request-data),
            name: (get name request-data),
            verified: true,
            verification-date: block-height,
            specializations: (get specializations request-data)
          }
        )
        (map-set verification-requests
          { request-id: request-id }
          (merge request-data { status: "approved" })
        )
        (ok true)
      )
      ERR_NOT_FOUND
    )
    ERR_UNAUTHORIZED
  )
)

;; Read-only functions
(define-read-only (is-verified-architect (architect principal))
  (match (map-get? architects { architect: architect })
    architect-data (get verified architect-data)
    false
  )
)

(define-read-only (get-architect-info (architect principal))
  (map-get? architects { architect: architect })
)

(define-read-only (get-verification-request (request-id uint))
  (map-get? verification-requests { request-id: request-id })
)
