# Form Workflow

Generic lifecycle:

DRAFT -> IN_PROGRESS -> REVIEW -> APPROVED -> FINALIZED -> ARCHIVED

Rules:
- FINALIZED operational records are immutable.
- Corrections create a new revision or controlled amendment.
- Every transition creates an audit event.
- Reprints never replace the original document.
- Approval permissions are role-based.
