;; Collaboration Platform Contract
;; Facilitates construction project collaboration

(define-constant ERR_UNAUTHORIZED (err u300))
(define-constant ERR_NOT_FOUND (err u301))
(define-constant ERR_INVALID_INPUT (err u302))

;; Data structures
(define-map collaboration-spaces
  { space-id: uint }
  {
    owner: principal,
    model-id: uint,
    name: (string-ascii 100),
    description: (string-ascii 500),
    created-at: uint,
    status: (string-ascii 20)
  }
)

(define-map space-members
  { space-id: uint, member: principal }
  {
    role: (string-ascii 50),
    joined-at: uint,
    invited-by: principal
  }
)

(define-map collaboration-messages
  { message-id: uint }
  {
    space-id: uint,
    sender: principal,
    content: (string-ascii 1000),
    timestamp: uint,
    message-type: (string-ascii 20)
  }
)

(define-data-var next-space-id uint u1)
(define-data-var next-message-id uint u1)

;; Public functions
(define-public (create-collaboration-space
  (model-id uint)
  (name (string-ascii 100))
  (description (string-ascii 500)))
  (let ((space-id (var-get next-space-id)))
    (if (> (len name) u0)
      (begin
        (map-set collaboration-spaces
          { space-id: space-id }
          {
            owner: tx-sender,
            model-id: model-id,
            name: name,
            description: description,
            created-at: block-height,
            status: "active"
          }
        )
        ;; Add owner as admin member
        (map-set space-members
          { space-id: space-id, member: tx-sender }
          {
            role: "admin",
            joined-at: block-height,
            invited-by: tx-sender
          }
        )
        (var-set next-space-id (+ space-id u1))
        (ok space-id)
      )
      ERR_INVALID_INPUT
    )
  )
)

(define-public (invite-member
  (space-id uint)
  (member principal)
  (role (string-ascii 50)))
  (match (map-get? collaboration-spaces { space-id: space-id })
    space-data
    (if (is-space-admin space-id tx-sender)
      (begin
        (map-set space-members
          { space-id: space-id, member: member }
          {
            role: role,
            joined-at: block-height,
            invited-by: tx-sender
          }
        )
        (ok true)
      )
      ERR_UNAUTHORIZED
    )
    ERR_NOT_FOUND
  )
)

(define-public (post-message
  (space-id uint)
  (content (string-ascii 1000))
  (message-type (string-ascii 20)))
  (let ((message-id (var-get next-message-id)))
    (if (is-space-member space-id tx-sender)
      (begin
        (map-set collaboration-messages
          { message-id: message-id }
          {
            space-id: space-id,
            sender: tx-sender,
            content: content,
            timestamp: block-height,
            message-type: message-type
          }
        )
        (var-set next-message-id (+ message-id u1))
        (ok message-id)
      )
      ERR_UNAUTHORIZED
    )
  )
)

;; Read-only functions
(define-read-only (get-collaboration-space (space-id uint))
  (map-get? collaboration-spaces { space-id: space-id })
)

(define-read-only (is-space-member (space-id uint) (member principal))
  (is-some (map-get? space-members { space-id: space-id, member: member }))
)

(define-read-only (is-space-admin (space-id uint) (member principal))
  (match (map-get? space-members { space-id: space-id, member: member })
    member-data (is-eq (get role member-data) "admin")
    false
  )
)

(define-read-only (get-message (message-id uint))
  (map-get? collaboration-messages { message-id: message-id })
)

(define-read-only (get-member-info (space-id uint) (member principal))
  (map-get? space-members { space-id: space-id, member: member })
)
