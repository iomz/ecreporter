require 'ecreporter'

# Encoding
Encoding.default_external = Encoding.find('UTF-8')

# Timezone setting
Time.zone = 'Asia/Tokyo'

$stdout.sync = true #if development?
#\ -s puma -E production

use ECReporter::WebsocketHandler
run ECReporter::App

