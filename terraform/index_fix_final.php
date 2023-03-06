<?php

\$inp = \$_GET["inp"];

if (preg_match("/[A-Za-z0-9-]+/", \$inp)) {
        \$url = "https://www.shutterstock.com/image-photo/\$inp";
        echo file_get_contents(\$url);
}

?>