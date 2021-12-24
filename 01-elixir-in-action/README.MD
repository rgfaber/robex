# This is the output from studying the book 'Elixir in Action'

## Test-driven learning
We shall write tests first for every example in the book.

## Tooling

### mix test.watch
mix test.watch is an valuable extension if you want to practice TDD.
In order to enable mix test.watch, we had to include in **mix.exs**
```elixir
  defp deps do
    [
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
```
#### NOTE: do not forget to run 
```shell
$ mix deps.get
```