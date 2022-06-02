defmodule Mix.Tasks.Polyn.NewTest do
  use ExUnit.Case, async: true

  @moduletag :tmp_dir

  alias Mix.Tasks.Polyn.New

  test "initializes git", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "polyn_admin")
    New.run(["--path", path])

    assert File.dir?(Path.join(path, ".git"))
  end

  test "removes test dir", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "polyn_admin")
    New.run(["--path", path])

    refute File.dir?(Path.join(path, "test"))
  end

  test "removes lib dir", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "polyn_admin")
    New.run(["--path", path])

    refute File.dir?(Path.join(path, "lib"))
  end

  test "creates priv dirs", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "polyn_admin")
    New.run(["--path", path])

    assert File.exists?(Path.join(path, "priv/polyn/schemas/.gitkeep"))
    assert File.exists?(Path.join(path, "priv/polyn/migrations/.gitkeep"))
  end

  test "copies readme", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "polyn_admin")
    New.run(["--path", path])

    assert File.read!(Path.join(path, "README.md")) =~
             "This codebase is a centralized place to manage your NATS server"
  end

  test "copies toolversions", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "polyn_admin")
    New.run(["--path", path])

    assert File.exists?(Path.join(path, ".tool-versions"))
  end

  test "adds mix file with correct deps", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "polyn_admin")
    New.run(["--path", path])

    content = File.read!(Path.join(path, "mix.exs"))
    assert content =~ ":polyn_admin"
    assert content =~ "{:polyn_migrator, \"~>"
  end
end
