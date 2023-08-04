# Header
jwt_header=$(echo -n '{"alg":"HS256","typ":"JWT"}' | base64 | sed s/\+/-/g | sed 's/\//_/g' | sed -E s/=+$//)
echo "HEADER: "$jwt_header

# Payload
payload=$(echo -n '{"iss":"midominio.com","exp":1540839345,"name":"Pedro Perez","email":"pedroperez@midominio.com","iat":1516239022}' | base64 | sed s/\+/-/g | sed 's/\//_/g' | sed -E s/=+$//)
echo "PAYLOAD: "$payload

clave_secreta='Yjyg0H_3~3JOr1g-'
echo -n "Clave Secreta: "$clave_secreta

hexsecreta=$(echo -n "$clave_secreta" | xxd -p | tr -d '\n')
echo  \n"Clave en Hexadecimal: " $hexsecreta

# Firma hmac
hmac_signatureHex=$(echo -n "${jwt_header}.${payload}" | openssl dgst -sha256 -mac HMAC -macopt hexkey:$hexsecreta -binary | base64 | sed 's/\+/-/g' | sed 's/\//_/g' | sed -E 's/=+$//')
echo "Firma o SIGNATURE: "$hmac_signatureHex

# Token
jwt="${jwt_header}.${payload}.${hmac_signatureHex}"
echo "JSON Web TOKEN (JWT): "$jwt