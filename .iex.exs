defmodule H do
  @required "c"
  @petals ["a", "b", "n", "o", "r", "l"]
  def file() do
    petals = MapSet.new(@petals)
    required = MapSet.new([@required])

    ignore =
      MapSet.new([
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z"
      ])
      |> MapSet.difference(petals)
      |> MapSet.difference(required)

    File.stream!("/Users/blakedietz/projects/dwyl/english-words/words_alpha.txt")
    |> Stream.map(&String.trim/1)
    |> Stream.filter(fn
      word when byte_size(word) > 3 ->
        String.contains?(word, @required) and
          not Enum.any?(ignore, fn letter ->
            String.contains?(word, letter)
          end)

      _ ->
        false
    end)
    |> Enum.to_list()
    |> IO.inspect(limit: :infinity)
  end
end
