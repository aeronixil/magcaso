# Validate forms with clear ownership: Compare two approaches

**Topic:** Flutter  
**Summary:** Connect controllers, validators, submission, and cleanup into a predictable form flow.

## Learning goal

Connect controllers, validators, submission, and cleanup into a predictable form flow.

## How it works

A `Form` groups fields and exposes validation through `FormState`. A `TextEditingController` gives explicit access to text and must be disposed by its owner. Validation should be timely, specific, and repeated at the trusted server boundary.

## Worked example

Give the form a `GlobalKey<FormState>`, validate date ordering as well as required fields, disable duplicate submission while saving, and dispose controllers in the owning State. Keep server validation authoritative.

## Watch for

Client-side validation improves feedback but cannot enforce authorization or guarantee the submitted data is valid.

## Key terms

Form, FormState, validator, controller, dispose, server validation

## Practice context

A chair request form requires start and end dates, a message length limit, and confirmation before submission.

## Exercise

Compare the recommended approach with one plausible alternative. Choose based on this scenario's ownership, safety, and maintenance needs.

Scenario: A chair request form requires start and end dates, a message length limit, and confirmation before submission.

Use this concept: A `Form` groups fields and exposes validation through `FormState`. A `TextEditingController` gives explicit access to text and must be disposed by its owner. Validation should be timely, specific, and repeated at the trusted server boundary.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Client-side validation improves feedback but cannot enforce authorization or guarantee the submitted data is valid.
