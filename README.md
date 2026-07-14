# nyudl-mdi-message

Language-neutral **JSON Schema** for New York University Digital Library's
Message Driven Infrastructure (MDI) message contract.

## What this repository is

This repository is the **source of truth** for the shape of the two envelopes
exchanged between the job orchestrator ([go-rsbe](https://github.com/nyudlts/go-rsbe))
and the workers that carry out a job's tasks:

- **Dispatch** — sent by the orchestrator to a worker's queue to ask it to
  perform one task (one workflow step). See
  [`schemas/dispatch.schema.json`](schemas/dispatch.schema.json).
- **Result** — published by the worker (to the address named by the dispatch's
  `reply_to`) to report the outcome of that task. See
  [`schemas/result.schema.json`](schemas/result.schema.json).

The schemas are [JSON Schema draft 2020-12](https://json-schema.org/). Messages
are serialized as JSON. All keys are `snake_case`.

The canonical **Go binding** of this contract lives in
[`github.com/nyudlts/go-mdi`](https://github.com/nyudlts/go-mdi) (package `mdi`).
When the two disagree, this schema is authoritative; keep the Go binding in sync.

> This repository previously shipped a Ruby gem (`NYUDL::MDI::Message`). The Ruby
> code has been removed in favor of the language-neutral schema so that workers
> in any language can share one contract.

## Contract version

The current envelope schema version is **`1.0.0`** (the value carried in each
message's `version` field).

## Dispatch

| key          | required | description                                                        |
|--------------|----------|--------------------------------------------------------------------|
| `version`    | yes      | envelope schema version (semver)                                   |
| `request_id` | yes      | UUID; the task id, used as a deterministic idempotency key         |
| `job_id`     | yes      | UUID of the job this task belongs to                               |
| `task_id`    | yes      | UUID of the task to perform                                        |
| `step_id`    | yes      | workflow step id this task realizes                                |
| `params`     | yes      | object of service-specific key/value pairs the worker needs        |
| `reply_to`   | yes      | address where the worker must publish its Result                   |

## Result

| key          | required | description                                                        |
|--------------|----------|--------------------------------------------------------------------|
| `version`    | yes      | envelope schema version (semver)                                   |
| `request_id` | yes      | UUID; echo of the dispatch `request_id` (the task id)              |
| `job_id`     | yes      | UUID of the job this task belongs to                               |
| `task_id`    | yes      | UUID of the task that was performed                                |
| `outcome`    | yes      | `success` or `failure` — drives the orchestrator's branch          |
| `agent`      | yes      | object with keys `name`, `version`, `host` (all non-empty)         |
| `data`       | no       | optional worker output, persisted by the orchestrator             |
| `start_time` | no       | operation start timestamp, ISO-8601 UTC (RFC 3339, trailing `Z`)  |
| `end_time`   | no       | operation finish timestamp, ISO-8601 UTC (RFC 3339, trailing `Z`) |

### `outcome`

`outcome` is a symmetric binary signal that mirrors the workflow DSL's
`on_success` / `on_failure` transitions: it tells the orchestrator which branch
to take, not merely that the task finished (completion is implied by the Result
existing). Operations without an intrinsic pass/fail semantics report `success`
to mean "proceed with the workflow".

### Constraint not expressible in JSON Schema

When both `start_time` and `end_time` are present, `start_time` must be
**`<=`** `end_time`. JSON Schema cannot express this cross-field relationship, so
validators and services must enforce it.

## Examples

Conforming sample messages live in [`examples/`](examples):

- [`examples/dispatch.example.json`](examples/dispatch.example.json)
- [`examples/result.example.json`](examples/result.example.json)

## Validating

Any JSON Schema draft 2020-12 validator works. For example, with
[`ajv-cli`](https://github.com/ajv-validator/ajv-cli):

```sh
npx -p ajv-cli@5 -p ajv-formats@3 ajv validate --spec=draft2020 -c ajv-formats \
  -s schemas/dispatch.schema.json -d examples/dispatch.example.json
npx -p ajv-cli@5 -p ajv-formats@3 ajv validate --spec=draft2020 -c ajv-formats \
  -s schemas/result.schema.json -d examples/result.example.json
```

## License

MIT — see [`LICENSE.txt`](LICENSE.txt).
