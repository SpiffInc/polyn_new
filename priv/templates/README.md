# Polyn Admin

This codebase is a centralized place to manage your NATS server in a controlled and predictable way.

## Migrations

Your migration files will live at `priv/polyn/migrations`. Use `mix polyn.gen.migration` to create new ones.

Use `mix polyn.migrate` to make changes to your NATS server

## Schemas

Your schema files will live at `priv/polyn/schemas`. Use `mix polyn.gen.schema` to create a new one