using DataFrames

# reading a text file
file_contents = open("tut2_file_to_read.txt") do file
    read(file, String)
end

file_contents_by_line = split(file_contents, "\n");

# writing a text file
open("will_write.txt", "w") do wfile
    for line in file_contents_by_line
        write(wfile, line)
    end
end


# better alternative to reading and writing files
using DelimtedFiles
