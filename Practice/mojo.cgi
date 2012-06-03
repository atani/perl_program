# Mojoliciousはこんなに簡単!
use Mojolicious::Lite;

get '/'  => 'index';

app->start;

__DATA__

@@ index.html.ep
Hello World!
