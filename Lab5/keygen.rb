require 'openssl'
require 'base64'
require 'securerandom'
require 'pp'

class ProductKey

  def initialize(l=20)
    @length = l
  end

  def generate(private_key, pass="password")
    priv = OpenSSL::PKey::RSA.new private_key
    s = pass + SecureRandom.random_bytes(@length)
    Base64.encode64(priv.private_encrypt(s))
    #puts 'Public:' rsa_public_key = OpenSSL::PKey::RSA.new(Base64.decode64(public_key))
  end

  def check (registration_key, public_key, pass="password")
    pub_key = OpenSSL::PKey::RSA.new public_key
    decrypted = pub_key.public_decrypt(Base64.decode64(registration_key))
    decrypted.start_with?('password')
  rescue
    return false
  end
end

#length = ARGV[0]
# #password = ARGV[1]

# p = ProductKey.new(20)

# pp p.generate('-----BEGIN RSA PRIVATE KEY-----
# MIIBOwIBAAJBALbkpbDFbZ54bM5ybwwdCqsUHjxWQF4B0Q1sAOBFEYdpxZJZ8dAz
# ycPzIgSlPc8yqjeqwJQtvCpktrntALpX1ksCAwEAAQJAYT0XyvBs48BrOSgmWm5m
# aab8nF/PQSv+FgDCRnryYue3WZOpUqITB0w6ivC68G/+Mf6IXyE4ljqw2iIAdjyv
# YQIhAOE20o2bLPMtziEOdH0KGpN0gNYpe38jGyvGw7k5gZd9AiEAz+TWZRJpc9yX
# 5dew3xcBtIhaTPFmVLgmfU7FwIWW32cCIQCvKK9LmUO1gouN5CsvUNtokbTeW/cD
# 467vNjDlb1deFQIhAK55pZ1p2GrOpgTWArEYg+vZy79rkbBkZJkh9UFgXIDdAiBm
# Rglcmt9cD2Vqg7xMr7cP3FJbSmJffSwYve1fazuZOw==
# -----END RSA PRIVATE KEY-----', 'test')
