# Informational Security - Laboratory Work #1

### Objective 
-----
Understand the purpose of hashing algorithms and create a tool that solves a problem using one of them.

### Duplicate file finder
-----
In this laboratory  work I'll show a form of using **cryptographic hahes**. The written program objective is to find files that are dublicated (have same content), using hashes.
##### Cryptographic hashes
A cryptographic hash function is a hash function which is considered practically impossible to invert, that is, to recreate the input data from its hash value alone. It is a hash function which takes an `input` (or `message`) and returns a `fixed-size alphanumeric string`, which is called the `hash value` (sometimes called a message `digest`, a digital fingerprint, a digest or a `checksum`).

##### Working principles
1. Makes list of files located in the directory and subdirectories where the program is located. (included hidden files).
2. Encodes (using `MD5` hashing algorithm) the content of the file into a checksum.
3. Stores the checksum into a `Hash` container as a `key` (new key if there is no precedent) and the filename as a value for that key into a table, as follows:

```ruby
{ "key" => ["filename1.ext", "filename2.ext"] } 
```

4. Outputs the results for which table with filenames has size  > 2. Result example:

```
duplicates:
  test_folder/text1.txt
  test_folder/text2.txt
  text1.txt
  text2.txt
 ```

##### How to use
You have to have `Ruby` installed in first place.
Place inside folder is wanted to be scanned and then run in your favourite CLI 
```
ruby dubfinder.rb
```

To run it every 10 minutes, write (scheduled task): 
```
*/10 * * * * ruby dubfinder.rb
```

##### Tackling large files (that don't fit in RAM)
As it turns out, Ruby `Digest` class has implemented own mechanisms to tackle that. It takes not a string as input, but a file path and it return the checksum of that file content.

##### Potential improvements
  * store checksums into a database like sqlite;
  * implement more paramenters for comparing mechanisms (file dimension, first characters checksum for fast hashing in case of big files);
  * implement the program in a more user-friendly way (being able to receive parameters, UI etc.);
  * delete duplicates at user request.
 
##### Conclusion 

The application works good on small folders and files and it's quite fast. The improvements describe above would make a lot more useful. It was an interesting experience to dive into cryptographic hash functions and write a simplified tool that I used for years. During research, I found a lot of domains where checksums are used that I did not realized before. It is a fast way to check things like integrity, differences between chunks of data, validation and much more.
