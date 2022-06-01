# Polyn Admin

This codebase is a centralized place to manage your NATS server in a controlled and predictable way. It is also intended to help everybody working on the system to understand what data is available in the system.

While this is a centralized codebase it is not meant to become a productivity bottleneck. Anybody who is working on a component in your system should have access to make changes. Peer-review is still a good idea, but it should be flexible. You don't want to create a situation where a handful of very busy people are the only ones allowed to approve changes for the entire organization.

## Migrations

Your migration files will live at `priv/polyn/migrations`. Use `mix polyn.gen.migration` to create new ones.

Use `mix polyn.migrate` to make changes to your NATS server

## Schemas

Your schema files will live at `priv/polyn/schemas`. Use `mix polyn.gen.schema` to create a new one