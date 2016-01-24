#### Laboratory work #5

Registration Number Verification
================================

#### Objective:
- Create a program that will generate registration numbers and verifies them.

The little Ruby program has two functions: `generate` and `check`. 
`generate` method looks like this:
```
def generate(private_key, pass="password")
    priv = OpenSSL::PKey::RSA.new private_key
    s = pass + SecureRandom.random_bytes(@length)
    Base64.encode64(priv.private_encrypt(s))
    #puts 'Public:' rsa_public_key = OpenSSL::PKey::RSA.new(Base64.decode64(public_key))
  end
```
It will:
- generate a private key;
- generate a random sequence of bytes and add it to password string;
- encrypt the result of previous step using the private key generated at first step;
- encode it into BASE64 and return the result, which is our key.



The method `check` looks like this:
```
  def check (registration_key, public_key, pass="password")
    pub_key = OpenSSL::PKey::RSA.new public_key
    decrypted = pub_key.public_decrypt(Base64.decode64(registration_key))
    decrypted.start_with?('password')
  rescue
    return false
  end
```
It will:
- decode the key from BASE64;
- use the public key and decode the meesage;
- check for the password that was used initially;

Conclusion
__________
  Because of Ruby libraries like OpenSSL it was easy to create a simple and insecure key generator. As improvement may be using a more sophisticated algorithm and other than interpreted languages because if a person intented to crack it, will do it very easy.






