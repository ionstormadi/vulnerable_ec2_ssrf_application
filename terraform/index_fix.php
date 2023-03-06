<?php

\$whitelist = array(
  "www.shutterstock.com"
);

\$url = \$_GET["url"];
\$parsed_url  = parse_url(\$url);
//echo \$parsed_url['scheme'];

//echo \$parsed_url['host'];

if (in_array(\$parsed_url['host'], \$whitelist)) {
      echo file_get_contents(\$url);
}

?>