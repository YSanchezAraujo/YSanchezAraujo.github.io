# Reading and writing files

A central part to doing anything with computers, let alone machine learning, or
data analysis is reading in data. Here we'll cover some methods by which we
can read in data. As a first example we'll read in a simple text file. The
contents of the text file don't matter, but see the example **put example here**
if you're curious. Assuming that the text file is in the same directory that
Julia is running in, you can read it in as follows:

```julia
file_contents = open("tut2_file_to_read.txt") do file
    read(file, String)
end

file_contents_by_line = split(file_contents, "\n");
```

By inspecting `file_contents` you see that everything in the file that was read
in is represented as one string. You'll notice that the new line character `\n`,
appears, and it tells us that new lines begin after that character in the actual
text file. We can use this to our advance and split the contents of the file,
according to the new line character. That is what `file_contents_by_line` represents.

Now to do the second part, write files. You can write the contents of `file_contents_by_line`
as follows:

```julia
open("will_write.txt", "w") do wfile
    for line in file_contents_by_line
        write(wfile, line)
    end
end
```

To be honest though, you probably don't want to use the methods outline above
to read and write data. They're simply displayed to show that this type of
functionality is available. Simpler and probably better suited to the task
alternatives are using the functions provided by the packages `DelimitedFiles`
and `CSV`.
