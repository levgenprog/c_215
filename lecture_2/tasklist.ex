defmodule Tasklist do
@filename "task_list.md"
import File, only: [write: 3, read: 1]
def add(taskname)
  task = "[] " <> taskname <> "\n"
  write(@filename, task, [:append])
end

def show_list do
  read(@filename)
end
end
