#!/bin/bash

cd /var/www/html/
sed -i -e "s/nairobi-production-sql-cet.azure.cet.ac.il/$SERVER/g" index9.php
sed -i -e "/myUser/{s/nairobi/$USER/g}" index9.php
sed -i -e "s/StarTr3ck!/$PASS/g" index9.php
sed -i -e "/myDB/{s/test-sql/$DB/g}" index9.php

cp index9.php index9.txt

/usr/sbin/apache2ctl -D FOREGROUND

