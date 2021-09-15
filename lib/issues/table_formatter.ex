defmodule TableFormatter do
  import Enum, only: [each: 2, map: 2, map_join: 3, max: 2]

  @doc """
  Takes a list of row data, where each row is a Map, and a list
  of headers. Prints a table to STDOUT of the data from each row
  identified by each header. That is, each header identifies
  a column, and those columns are extracted and printed from 
  the rows. We calcuate the width of each column to fit
  the longest element in that column.
  """
  def print_table_for_columns(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         column_widths = widths_of(data_by_columns),
         format = format_for(column_widths) do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(column_widths))
      puts_in_columns(data_by_columns, format)
    end
  end

  @doc """
  Given a list of rows, where each row contains a keyed list
  of columns, return a list containing lists of the data in
  each column. The `headers` parameter contains the list
  of columns to extract.
  ## Example
    iex> list = [
                  Enum.into([{"a", "1"}, {"b", "2"}, {"c", "3"}], %{}),
                  Enum.into([{"a", "4"}, {"b", "5"}, {"c", "6"}], %{})
                ]
    iex> Issues.TableFormatter.split_into_columns(list, ["a", "b", "c"])
    [ [ "1", "4" ], [ "2", "5" ], [ "3", "6" ] ]
  """
  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end

  @doc """
  Return a binary (string) version of our parameter.
  ## Example
    iex> Issues.TableFormatter.printable("a")
    "a"
    iex> Issues.TableFormatter.printable(99)
    "99"
  """
  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  @doc """
  Given a list con
  """
  def widths_of(columns) do
    for column <- columns do
      column
      |> Enum.map(&String.length/1)
      |> Enum.max()
    end
  end

  def format_for(column_widths) do
    Enum.map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(column_widths) do
    Enum.map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_one_line_in_columns(&1, format))
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
