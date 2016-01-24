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