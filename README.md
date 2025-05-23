# of: Overwrite Files

## 1. Purpose
This script securely overwrites existing files in a directory, including all of its nested sub directories.

Before you sell your computer or give it to another person or give back your work computer to the company when you quit a job, you must securely delete your important personal files. **Deleting or overwriting a file once is not secured enough. Anybody can use appropriate tools to recover the original file's content.**


This script overwrites the files 20 times with random strings. Nobody can recover the original contents of the files.

## 2. Prerequisites

You must have `Ruby` interpreter installed on your computer.

### Verify whether Ruby is installed:

- Open terminal.

- Type `ruby -v`, if you have Ruby installed on your machine, you should see something similar to this:
```
ruby 3.3.2 (2024-05-30 revision e5a195edf6) [x86_64-darwin22]
```


(The ruby version on your machine might be different.)


If you don't have Ruby installed on your machine, search "How to download and install Ruby" to find a way to install Ruby on your machine.

## 3. Run the program

- Download the file `of.rb` to your machine.

- Open terminal.

- Change the directory to where you save the file `of.rb`

- Run the command:
```
ruby of.rb <PATH TO THE DIRECTORY TO OVERWRITE FILES>
```

Example:

```
ruby of.rb $HOME/test_of
```


After running the script, you can check the file `error_log.txt` for any errors happening during the overwriting process.
