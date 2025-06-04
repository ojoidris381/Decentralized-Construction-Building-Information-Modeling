# Decentralized Construction Building Information Modeling (BIM)

A blockchain-based Building Information Modeling system built on the Stacks blockchain using Clarity smart contracts. This system provides decentralized management of construction projects with architect verification, model management, collaboration tools, version control, and compliance checking.

## Overview

This decentralized BIM system consists of five interconnected smart contracts that work together to provide a comprehensive construction project management platform:

1. **Architect Verification Contract** - Manages architect registration and verification
2. **Model Management Contract** - Handles building information models and permissions
3. **Collaboration Platform Contract** - Facilitates team collaboration and communication
4. **Version Control Contract** - Tracks model versions and changes
5. **Compliance Checking Contract** - Validates building code compliance

## Features

### 🏗️ Architect Verification
- Architect registration and license verification
- Specialization tracking
- Verification request management
- Decentralized architect credentialing

### 📊 Model Management
- Secure model storage with hash verification
- Permission-based access control
- Project metadata management
- Multi-user model collaboration

### 🤝 Collaboration Platform
- Team workspace creation
- Role-based member management
- Real-time messaging and communication
- Project-specific collaboration spaces

### 🔄 Version Control
- Git-like version tracking for BIM models
- Branch management for parallel development
- Commit history with detailed change logs
- Merge and rollback capabilities

### ✅ Compliance Checking
- Building code rule management
- Automated compliance verification
- Compliance status tracking
- Audit trail for regulatory requirements

## Smart Contract Architecture

### Architect Verification Contract
\`\`\`clarity
;; Key functions:
- request-verification: Submit architect verification request
- verify-architect: Approve architect verification (admin only)
- is-verified-architect: Check if architect is verified
- get-architect-info: Retrieve architect details
  \`\`\`

### Model Management Contract
\`\`\`clarity
;; Key functions:
- create-model: Create new BIM model
- update-model: Update existing model
- grant-permission: Manage user permissions
- get-model: Retrieve model information
  \`\`\`

### Collaboration Platform Contract
\`\`\`clarity
;; Key functions:
- create-collaboration-space: Create team workspace
- invite-member: Add team members
- post-message: Send messages in workspace
- get-collaboration-space: Retrieve workspace details
  \`\`\`

### Version Control Contract
\`\`\`clarity
;; Key functions:
- initialize-version-control: Set up version tracking
- commit-version: Create new model version
- create-branch: Create development branch
- get-version: Retrieve specific version
  \`\`\`

### Compliance Checking Contract
\`\`\`clarity
;; Key functions:
- create-compliance-rule: Define building code rules
- perform-compliance-check: Execute compliance verification
- get-model-compliance-status: Check compliance status
- is-model-compliant: Verify model compliance
  \`\`\`

## Getting Started

### Prerequisites
- Stacks blockchain node or testnet access
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd decentralized-bim
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:
\`\`\`bash
# Deploy architect verification contract
stx deploy_contract architect-verification contracts/architect-verification.clar

# Deploy model management contract
stx deploy_contract model-management contracts/model-management.clar

# Deploy collaboration platform contract
stx deploy_contract collaboration-platform contracts/collaboration-platform.clar

# Deploy version control contract
stx deploy_contract version-control contracts/version-control.clar

# Deploy compliance checking contract
stx deploy_contract compliance-checking contracts/compliance-checking.clar
\`\`\`

## Usage Examples

### 1. Architect Verification
\`\`\`clarity
;; Request architect verification
(contract-call? .architect-verification request-verification
"ARCH-12345"
"John Smith"
(list "residential" "commercial"))

;; Verify architect (admin only)
(contract-call? .architect-verification verify-architect u1)
\`\`\`

### 2. Create and Manage BIM Model
\`\`\`clarity
;; Create new model
(contract-call? .model-management create-model
'SP1ARCHITECT123
"Downtown Office Complex"
"abc123def456..."
"Modern office building with sustainable features")

;; Grant edit permission
(contract-call? .model-management grant-permission u1 'SP1ENGINEER456 "edit")
\`\`\`

### 3. Set Up Collaboration
\`\`\`clarity
;; Create collaboration space
(contract-call? .collaboration-platform create-collaboration-space
u1
"Downtown Office Project Team"
"Collaboration space for the downtown office complex project")

;; Invite team member
(contract-call? .collaboration-platform invite-member u1 'SP1CONTRACTOR789 "contributor")
\`\`\`

### 4. Version Control
\`\`\`clarity
;; Initialize version control
(contract-call? .version-control initialize-version-control
u1
"initial-hash-123"
"Initial model commit")

;; Commit new version
(contract-call? .version-control commit-version
u1
"updated-hash-456"
u1
"Added HVAC system details"
"Updated mechanical systems and ductwork")
\`\`\`

### 5. Compliance Checking
\`\`\`clarity
;; Create compliance rule
(contract-call? .compliance-checking create-compliance-rule
"Fire Safety Exit Requirements"
"Minimum two exits required for buildings over 1000 sq ft"
"fire-safety"
"critical")

;; Perform compliance check
(contract-call? .compliance-checking perform-compliance-check
u1 u1 u1
"Model meets fire safety exit requirements - 4 exits identified"
"passed")
\`\`\`

## Data Structures

### Architect Data
- License number and verification status
- Name and specializations
- Verification date and history

### Model Data
- Owner and architect information
- Project metadata and model hash
- Permission levels and access control

### Collaboration Data
- Workspace members and roles
- Message history and communication logs
- Project-specific discussions

### Version Data
- Model version history and branches
- Commit messages and change summaries
- Parent-child version relationships

### Compliance Data
- Building code rules and categories
- Compliance check results and status
- Audit trails and verification history

## Security Considerations

- **Access Control**: Role-based permissions for all operations
- **Data Integrity**: Hash-based model verification
- **Audit Trail**: Complete history of all changes and actions
- **Decentralization**: No single point of failure
- **Transparency**: All actions recorded on blockchain

## Testing

The project includes comprehensive tests using Vitest:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test architect-verification.test.js

# Run tests with coverage
npm run test:coverage
\`\`\`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue in the GitHub repository or contact the development team.

## Roadmap

- [ ] Integration with IPFS for model storage
- [ ] Mobile application for field workers
- [ ] Integration with IoT sensors for real-time monitoring
- [ ] Advanced analytics and reporting features
- [ ] Multi-chain support for broader adoption
