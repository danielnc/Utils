# from Ruby-land
require 'openssl'

d = OpenSSL::Cipher.new("AES-128-CBC")
d.decrypt
key = OpenSSL::PKCS5.pbkdf2_hmac_sha1("passwd", "salt", 1024, d.key_len)
d.key = key
d.iv = "d82efb86de31cbc8d70abc7fdebc5a75".scan(/../).map{|b|b.hex}.pack('c*')
data = "bb1ea3496f122ca4a89ec11bfe31a556".scan(/../).map{|b|b.hex}.pack('c*')
result = d.update(data) << d.final
puts result

