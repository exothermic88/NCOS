# curl
# Autogenerated from man page /usr/share/man/man1/curl.1.gz
complete -c curl -l abstract-unix-socket -d '(HTTP) Connect through an abstract Unix domain socket, instead of using the n…'
complete -c curl -l alt-svc -d '(HTTPS) Enable the alt-svc parser'
complete -c curl -l anyauth -d '(HTTP) Figure out authentication method automatically, and use the most secur…'
complete -c curl -s a -l append -d '(FTP SFTP) When used in an upload, this option makes curl append to the targe…'
complete -c curl -l aws-sigv4 -d '(HTTP) Use AWS V4 signature authentication in the transfer'
complete -c curl -l basic -d '(HTTP) Use HTTP Basic authentication with the remote host'
complete -c curl -l ca-native -d '(TLS) Use the CA store from the native operating system to verify the peer'
complete -c curl -l cacert -d '(TLS) Use the specified certificate file to verify the peer'
complete -c curl -l capath -d '(TLS) Use the specified certificate directory to verify the peer'
complete -c curl -s E -l cert -d '(TLS) Use the specified client certificate file when getting a file with HTTP…'
complete -c curl -l cert-status -d '(TLS) Verify the status of the server certificate by using the Certificate St…'
complete -c curl -l cert-type -d '(TLS) Set type of the provided client certificate'
complete -c curl -l ciphers -d '(TLS) Specifies which ciphers to use in the connection'
complete -c curl -l compressed -d '(HTTP) Request a compressed response using one of the algorithms curl support…'
complete -c curl -l compressed-ssh -d '(SCP SFTP) Enables built-in SSH compression'
complete -c curl -s K -l config -d 'Specify a text file to read curl arguments from'
complete -c curl -l connect-timeout -d 'Maximum time in seconds that you allow curl\'s connection to take'
complete -c curl -l connect-to -d 'For a request intended for the "HOST1:PORT1" pair, connect to "HOST2:PORT2" i…'
complete -c curl -s C -l continue-at -d 'Resume a previous transfer from the given byte offset'
complete -c curl -s b -l cookie -d '(HTTP) Pass the data to the HTTP server in the Cookie header'
complete -c curl -s c -l cookie-jar -d '(HTTP) Specify to which file you want curl to write all cookies after a compl…'
complete -c curl -l create-dirs -d 'When used in conjunction with the -o, --output option, curl creates the neces…'
complete -c curl -l create-file-mode -d '(SFTP SCP FILE) When curl is used to create files remotely using one of the s…'
complete -c curl -l crlf -d '(FTP SMTP) Convert line feeds to carriage return plus line feeds in upload'
complete -c curl -l crlfile -d '(TLS) Provide a file using PEM format with a Certificate Revocation List that…'
complete -c curl -l curves -d '(TLS) Set specific curves to use during SSL session establishment according t…'
complete -c curl -s d -l data -d '(HTTP MQTT) Sends the specified data in a POST request to the HTTP server, in…'
complete -c curl -l data-ascii -d '(HTTP) This option is just an alias for -d, --data'
complete -c curl -l data-binary -d '(HTTP) Post data exactly as specified with no extra processing whatsoever'
complete -c curl -l data-raw -d '(HTTP) Post data similarly to -d, --data but without the special interpretati…'
complete -c curl -l data-urlencode -d '(HTTP) Post data, similar to the other -d, --data options with the exception …'
complete -c curl -l delegation -d '(GSS/kerberos) Set LEVEL what curl is allowed to delegate when it comes to us…'
complete -c curl -l digest -d '(HTTP) Enables HTTP Digest authentication'
complete -c curl -s q -l disable -d 'If used as the first parameter on the command line, the curlrc config file is…'
complete -c curl -l disable-eprt -d '(FTP) Disable the use of the EPRT and LPRT commands when doing active FTP tra…'
complete -c curl -l disable-epsv -d '(FTP) Disable the use of the EPSV command when doing passive FTP transfers'
complete -c curl -l disallow-username-in-url -d 'Exit with error if passed a URL containing a username'
complete -c curl -l dns-interface -d '(DNS) Send outgoing DNS requests through the given interface'
complete -c curl -l dns-ipv4-addr -d '(DNS) Bind to a specific IP address when making IPv4 DNS requests, so that th…'
complete -c curl -l dns-ipv6-addr -d '(DNS) Bind to a specific IP address when making IPv6 DNS requests, so that th…'
complete -c curl -l dns-servers -d '(DNS) Set the list of DNS servers to be used instead of the system default'
complete -c curl -l doh-cert-status -d 'Same as --cert-status but used for DoH (DNS-over-HTTPS)'
complete -c curl -l doh-insecure -d 'By default, every connection curl makes to a DoH server is verified to be sec…'
complete -c curl -l doh-url -d 'Specifies which DNS-over-HTTPS (DoH) server to use to resolve hostnames, inst…'
complete -c curl -s D -l dump-header -d '(HTTP FTP) Write the received protocol headers to the specified file'
complete -c curl -l ech -d '(HTTPS) Specifies how to do ECH (Encrypted Client Hello)'
complete -c curl -l egd-file -d '(TLS) Deprecated option (added in 7. 84. 0)'
complete -c curl -l engine -d '(TLS) Select the OpenSSL crypto engine to use for cipher operations'
complete -c curl -l etag-compare -d '(HTTP) Make a conditional HTTP request for the specific ETag read from the gi…'
complete -c curl -l etag-save -d '(HTTP) Save an HTTP ETag to the specified file'
complete -c curl -l expect100-timeout -d '(HTTP) Maximum time in seconds that you allow curl to wait for a 100-continue…'
complete -c curl -s f -l fail -d '(HTTP) Fail with error code 22 and with no response body output at all for HT…'
complete -c curl -l fail-early -d 'Fail and exit on the first detected transfer error'
complete -c curl -l fail-with-body -d '(HTTP) Return an error on server errors where the HTTP response code is 400 o…'
complete -c curl -l false-start -d '(TLS) Use false start during the TLS handshake'
complete -c curl -s F -l form -d '(HTTP SMTP IMAP) For the HTTP protocol family, emulate a filled-in form in wh…'
complete -c curl -l form-escape -d '(HTTP imap smtp) Pass on names of multipart form fields and files using backs…'
complete -c curl -l form-string -d '(HTTP SMTP IMAP) Similar to -F, --form except that the value string for the n…'
complete -c curl -l ftp-account -d '(FTP) When an FTP server asks for "account data" after username and password …'
complete -c curl -l ftp-alternative-to-user -d '(FTP) If authenticating with the USER and PASS commands fails, send this comm…'
complete -c curl -l ftp-create-dirs -d '(FTP SFTP) When an FTP or SFTP URL/operation uses a path that does not curren…'
complete -c curl -l ftp-method -d '(FTP) Control what method curl should use to reach a file on an FTP(S) server'
complete -c curl -l ftp-pasv -d '(FTP) Use passive mode for the data connection'
complete -c curl -s P -l ftp-port -d '(FTP) Reverses the default initiator/listener roles when connecting with FTP'
complete -c curl -l ftp-pret -d '(FTP) Send a PRET command before PASV (and EPSV)'
complete -c curl -l ftp-skip-pasv-ip -d '(FTP) Do not use the IP address the server suggests in its response to curl\'s…'
complete -c curl -l ftp-ssl-ccc -d '(FTP) Use CCC (Clear Command Channel) Shuts down the SSL/TLS layer after auth…'
complete -c curl -l ftp-ssl-ccc-mode -d '(FTP) Sets the CCC mode'
complete -c curl -l ftp-ssl-control -d '(FTP) Require SSL/TLS for the FTP login, clear for transfer'
complete -c curl -s G -l get -d '(HTTP) When used, this option makes all data specified with -d, --data, --dat…'
complete -c curl -s g -l globoff -d 'Switch off the URL globbing function'
complete -c curl -l happy-eyeballs-timeout-ms -d 'Happy Eyeballs is an algorithm that attempts to connect to both IPv4 and IPv6…'
complete -c curl -l haproxy-clientip -d '(HTTP) Sets a client IP in HAProxy PROXY protocol v1 header at the beginning …'
complete -c curl -l haproxy-protocol -d '(HTTP) Send a HAProxy PROXY protocol v1 header at the beginning of the connec…'
complete -c curl -s I -l head -d '(HTTP FTP FILE) Fetch the headers only! HTTP-servers feature the command HEAD…'
complete -c curl -s H -l header -d '(HTTP IMAP SMTP) Extra header to include in information sent'
complete -c curl -s h -l help -d 'Usage help.  List all curl command line options within the given category'
complete -c curl -l hostpubmd5 -d '(SFTP SCP) Pass a string containing 32 hexadecimal digits'
complete -c curl -l hostpubsha256 -d '(SFTP SCP) Pass a string containing a Base64-encoded SHA256 hash of the remot…'
complete -c curl -l hsts -d '(HTTPS) Enable HSTS for the transfer'
complete -c curl -l 'http0.9' -d '(HTTP) Accept an HTTP version 0. 9 response.   HTTP/0'
complete -c curl -s 0 -l 'http1.0' -d '(HTTP) Use HTTP version 1'
complete -c curl -l 'http1.1' -d '(HTTP) Use HTTP version 1. 1.  This is the default with HTTP:// URLs'
complete -c curl -l http2 -d '(HTTP) Use HTTP/2'
complete -c curl -l http2-prior-knowledge -d '(HTTP) Issue a non-TLS HTTP requests using HTTP/2 directly without HTTP/1'
complete -c curl -l http3 -d '(HTTP) Attempt HTTP/3 to the host in the URL, but fallback to earlier HTTP ve…'
complete -c curl -l http3-only -d '(HTTP) Instructs curl to use HTTP/3 to the host in the URL, with no fallback …'
complete -c curl -l ignore-content-length -d '(FTP HTTP) For HTTP, Ignore the Content-Length header'
complete -c curl -s i -l include -d '(HTTP FTP) Include response headers in the output'
complete -c curl -s k -l insecure -d '(TLS SFTP SCP) By default, every secure connection curl makes is verified to …'
complete -c curl -l interface -d 'Perform the operation using a specified interface'
complete -c curl -l ip-tos -d '(All) Set Type of Service (TOS) for IPv4 or Traffic Class for IPv6'
complete -c curl -l ipfs-gateway -d '(IPFS) Specify which gateway to use for IPFS and IPNS URLs'
complete -c curl -s 4 -l ipv4 -d 'Use IPv4 addresses only when resolving hostnames, and not for example try IPv6'
complete -c curl -s 6 -l ipv6 -d 'Use IPv6 addresses only when resolving hostnames, and not for example try IPv4'
complete -c curl -l json -d '(HTTP) Sends the specified JSON data in a POST request to the HTTP server'
complete -c curl -s j -l junk-session-cookies -d '(HTTP) When curl is told to read cookies from a given file, this option makes…'
complete -c curl -l keepalive-cnt -d 'Set the maximum number of keepalive probes TCP should send but get no respons…'
complete -c curl -l keepalive-time -d 'Set the time a connection needs to remain idle before sending keepalive probe…'
complete -c curl -l key -d '(TLS SSH) Private key filename'
complete -c curl -l key-type -d '(TLS) Private key file type'
complete -c curl -l krb -d '(FTP) Enable Kerberos authentication and use'
complete -c curl -l libcurl -d 'Append this option to any ordinary curl command line, and you get libcurl-usi…'
complete -c curl -l limit-rate -d 'Specify the maximum transfer rate you want curl to use - for both downloads a…'
complete -c curl -s l -l list-only -d '(FTP POP3 SFTP FILE) When listing an FTP directory, force a name-only view'
complete -c curl -l local-port -d 'Set a preferred single number or range (FROM-TO) of local port numbers to use…'
complete -c curl -s L -l location -d '(HTTP) If the server reports that the requested page has moved to a different…'
complete -c curl -l location-trusted -d '(HTTP) Like -L, --location, but allows sending the name + password to all hos…'
complete -c curl -l login-options -d '(IMAP LDAP POP3 SMTP) Specify the login options to use during server authenti…'
complete -c curl -l mail-auth -d '(SMTP) Specify a single address'
complete -c curl -l mail-from -d '(SMTP) Specify a single address that the given mail should get sent from'
complete -c curl -l mail-rcpt -d '(SMTP) Specify a single email address, username or mailing list name'
complete -c curl -l mail-rcpt-allowfails -d '(SMTP) When sending data to multiple recipients, by default curl aborts SMTP …'
complete -c curl -s M -l manual -d 'Manual.  Display the huge help text.   Example: . nf  curl --manual '
complete -c curl -l max-filesize -d '(FTP HTTP MQTT) Specify the maximum size (in bytes) of a file to download'
complete -c curl -l max-redirs -d '(HTTP) Set maximum number of redirections to follow'
complete -c curl -s m -l max-time -d 'Set maximum time in seconds that you allow each transfer to take'
complete -c curl -l metalink -d 'This option was previously used to specify a Metalink resource'
complete -c curl -l mptcp -d 'Enables the use of Multipath TCP (MPTCP) for connections'
complete -c curl -l negotiate -d '(HTTP) Enable Negotiate (SPNEGO) authentication'
complete -c curl -s n -l netrc -d 'Make curl scan the '
complete -c curl -l netrc-file -d 'Set the netrc file to use'
complete -c curl -l netrc-optional -d 'Similar to -n, --netrc, but this option makes the '
complete -c curl -l next -d 'Use a separate operation for the following URL and associated options'
complete -c curl -l no-alpn -d '(HTTPS) Disable the ALPN TLS extension'
complete -c curl -s N -l no-buffer -d 'Disables the buffering of the output stream'
complete -c curl -l no-clobber -d 'When used in conjunction with the -o, --output, -J, --remote-header-name, -O,…'
complete -c curl -l no-keepalive -d 'Disables the use of keepalive messages on the TCP connection'
complete -c curl -l no-npn -d '(HTTPS) curl never uses NPN, this option has no effect (added in 7. 86. 0)'
complete -c curl -l no-progress-meter -d 'Option to switch off the progress meter output without muting or otherwise af…'
complete -c curl -l no-sessionid -d '(TLS) Disable curl\'s use of SSL session-ID caching'
complete -c curl -l noproxy -d 'Comma-separated list of hosts for which not to use a proxy, if one is specifi…'
complete -c curl -l ntlm -d '(HTTP) Use NTLM authentication'
complete -c curl -l ntlm-wb -d '(HTTP) Deprecated option (added in 8. 8. 0)'
complete -c curl -l oauth2-bearer -d '(IMAP LDAP POP3 SMTP HTTP) Specify the Bearer Token for OAUTH 2'
complete -c curl -s o -l output -d 'Write output to the given file instead of stdout'
complete -c curl -l output-dir -d 'Specify the directory in which files should be stored, when -O, --remote-name…'
complete -c curl -s Z -l parallel -d 'Makes curl perform all transfers in parallel as compared to the regular seria…'
complete -c curl -l parallel-immediate -d 'When doing parallel transfers, this option instructs curl to prefer opening u…'
complete -c curl -l parallel-max -d 'When asked to do parallel transfers, using -Z, --parallel, this option contro…'
complete -c curl -l pass -d '(SSH TLS) Passphrase for the private key'
complete -c curl -l path-as-is -d 'Do not handle sequences of /. / or /. / in the given URL path'
complete -c curl -l pinnedpubkey -d '(TLS) Use the specified public key file (or hashes) to verify the peer'
complete -c curl -l post301 -d '(HTTP) Respect RFC 7231/6. 4'
complete -c curl -l post302 -d '(HTTP) Respect RFC 7231/6. 4'
complete -c curl -l post303 -d '(HTTP) Violate RFC 7231/6. 4'
complete -c curl -l preproxy -d 'Use the specified SOCKS proxy before connecting to an HTTP or HTTPS -x, --pro…'
complete -c curl -s '#' -l progress-bar -d 'Make curl display transfer progress as a simple progress bar instead of the s…'
complete -c curl -l proto -d 'Limit what protocols to allow for transfers'
complete -c curl -o ftps -d '--proto -all,https,+http only enables http and https  --proto =http,https als…'
complete -c curl -l proto-default -d 'Use protocol for any provided URL missing a scheme'
complete -c curl -l proto-redir -d 'Limit what protocols to allow on redirects'
complete -c curl -s x -l proxy -d 'Use the specified proxy'
complete -c curl -l proxy-anyauth -d 'Automatically pick a suitable authentication method when communicating with t…'
complete -c curl -l proxy-basic -d 'Use HTTP Basic authentication when communicating with the given proxy'
complete -c curl -l proxy-ca-native -d '(TLS) Use the CA store from the native operating system to verify the HTTPS p…'
complete -c curl -l proxy-cacert -d 'Use the specified certificate file to verify the HTTPS proxy'
complete -c curl -l proxy-capath -d 'Same as --capath but used in HTTPS proxy context'
complete -c curl -l proxy-cert -d 'Use the specified client certificate file when communicating with an HTTPS pr…'
complete -c curl -l proxy-cert-type -d 'Set type of the provided client certificate when using HTTPS proxy'
complete -c curl -l proxy-ciphers -d 'Same as --ciphers but used in HTTPS proxy context'
complete -c curl -l proxy-crlfile -d 'Provide filename for a PEM formatted file with a Certificate Revocation List …'
complete -c curl -l proxy-digest -d 'Use HTTP Digest authentication when communicating with the given proxy'
complete -c curl -l proxy-header -d '(HTTP) Extra header to include in the request when sending HTTP to a proxy'
complete -c curl -l proxy-http2 -d '(HTTP) Negotiate HTTP/2 with an HTTPS proxy'
complete -c curl -l proxy-insecure -d 'Same as -k, --insecure but used in HTTPS proxy context'
complete -c curl -l proxy-key -d 'Specify the filename for your private key when using client certificates with…'
complete -c curl -l proxy-key-type -d 'Specify the private key file type your --proxy-key provided private key uses'
complete -c curl -l proxy-negotiate -d 'Use HTTP Negotiate (SPNEGO) authentication when communicating with the given …'
complete -c curl -l proxy-ntlm -d 'Use HTTP NTLM authentication when communicating with the given proxy'
complete -c curl -l proxy-pass -d 'Passphrase for the private key for HTTPS proxy client certificate'
complete -c curl -l proxy-pinnedpubkey -d '(TLS) Use the specified public key file (or hashes) to verify the proxy'
complete -c curl -l proxy-service-name -d 'Set the service name for SPNEGO when doing proxy authentication'
complete -c curl -l proxy-ssl-allow-beast -d 'Do not work around a security flaw in the TLS1'
complete -c curl -l proxy-ssl-auto-client-cert -d 'Same as --ssl-auto-client-cert but used in HTTPS proxy context'
complete -c curl -l proxy-tls13-ciphers -d '(TLS) Specify which cipher suites to use in the connection to your HTTPS prox…'
complete -c curl -l proxy-tlsauthtype -d 'Set TLS authentication type with HTTPS proxy'
complete -c curl -l proxy-tlspassword -d 'Set password to use with the TLS authentication method specified with --proxy…'
complete -c curl -l proxy-tlsuser -d 'Set username for use for HTTPS proxy with the TLS authentication method speci…'
complete -c curl -l proxy-tlsv1 -d 'Use at least TLS version 1. x when negotiating with an HTTPS proxy'
complete -c curl -s U -l proxy-user -d 'Specify the username and password to use for proxy authentication'
complete -c curl -l 'proxy1.0' -d 'Use the specified HTTP 1. 0 proxy'
complete -c curl -s p -l proxytunnel -d 'When an HTTP proxy is used -x, --proxy, this option makes curl tunnel the tra…'
complete -c curl -l pubkey -d '(SFTP SCP) Public key filename'
complete -c curl -s Q -l quote -d '(FTP SFTP) Send an arbitrary command to the remote FTP or SFTP server'
complete -c curl -l random-file -d 'Deprecated option.  This option is ignored (added in 7. 84. 0)'
complete -c curl -s r -l range -d '(HTTP FTP SFTP FILE) Retrieve a byte range (i. e'
complete -c curl -o 499 -d 'specifies the first 500 bytes'
complete -c curl -o 999 -d 'specifies the second 500 bytes'
complete -c curl -o 500 -d 'specifies the last 500 bytes'
complete -c curl -s 1 -d 'specifies the first and last byte only(*)(HTTP)'
complete -c curl -o 199 -d 'specifies two separate 100-byte ranges(*) (HTTP) . RE'
complete -c curl -l rate -d 'Specify the maximum transfer frequency you allow curl to use - in number of t…'
complete -c curl -l raw -d '(HTTP) When used, it disables all internal HTTP decoding of content or transf…'
complete -c curl -s e -l referer -d '(HTTP) Set the referrer URL in the HTTP request'
complete -c curl -s J -l remote-header-name -d '(HTTP) Tell the -O, --remote-name option to use the server-specified Content-…'
complete -c curl -s O -l remote-name -d 'Write output to a local file named like the remote file we get'
complete -c curl -l remote-name-all -d 'Change the default action for all given URLs to be dealt with as if -O, --rem…'
complete -c curl -s R -l remote-time -d 'Makes curl attempt to figure out the timestamp of the remote file that is get…'
complete -c curl -l remove-on-error -d 'Remove output file if an error occurs'
complete -c curl -s X -l request -d 'Change the method to use when starting the transfer'
complete -c curl -l request-target -d '(HTTP) Use an alternative target (path) instead of using the path as provided…'
complete -c curl -l resolve -d 'Provide a custom address for a specific host and port pair'
complete -c curl -l retry -d 'If a transient error is returned when curl tries to perform a transfer, it re…'
complete -c curl -l retry-all-errors -d 'Retry on any error.  This option is used together with --retry'
complete -c curl -l retry-connrefused -d 'In addition to the other conditions, consider ECONNREFUSED as a transient err…'
complete -c curl -l retry-delay -d 'Make curl sleep this amount of time before each retry when a transfer has fai…'
complete -c curl -l retry-max-time -d 'The retry timer is reset before the first transfer attempt'
complete -c curl -l sasl-authzid -d 'Use this authorization identity (authzid), during SASL PLAIN authentication, …'
complete -c curl -l sasl-ir -d 'Enable initial response in SASL authentication'
complete -c curl -l service-name -d 'Set the service name for SPNEGO'
complete -c curl -s S -l show-error -d 'When used with -s, --silent, it makes curl show an error message if it fails'
complete -c curl -s s -l silent -d 'Silent or quiet mode.  Do not show progress meter or error messages'
complete -c curl -l socks4 -d 'Use the specified SOCKS4 proxy'
complete -c curl -l socks4a -d 'Use the specified SOCKS4a proxy'
complete -c curl -l socks5 -d 'Use the specified SOCKS5 proxy - but resolve the hostname locally'
complete -c curl -l socks5-basic -d 'Use username/password authentication when connecting to a SOCKS5 proxy'
complete -c curl -l socks5-gssapi -d 'Use GSS-API authentication when connecting to a SOCKS5 proxy'
complete -c curl -l socks5-gssapi-nec -d 'As part of the GSS-API negotiation a protection mode is negotiated'
complete -c curl -l socks5-gssapi-service -d 'Set the service name for a socks server.  Default is rcmd/server-fqdn'
complete -c curl -l socks5-hostname -d 'Use the specified SOCKS5 proxy (and let the proxy resolve the hostname)'
complete -c curl -s Y -l speed-limit -d 'If a transfer is slower than this set speed (in bytes per second) for a given…'
complete -c curl -s y -l speed-time -d 'If a transfer runs slower than speed-limit bytes per second during a speed-ti…'
complete -c curl -l ssl -d '(FTP IMAP POP3 SMTP LDAP) Warning: this is considered an insecure option'
complete -c curl -l ssl-allow-beast -d '(TLS) Do not work around a security flaw in the TLS1'
complete -c curl -l ssl-auto-client-cert -d '(TLS) (Schannel) Automatically locate and use a client certificate for authen…'
complete -c curl -l ssl-no-revoke -d '(TLS) (Schannel) Disable certificate revocation checks'
complete -c curl -l ssl-reqd -d '(FTP IMAP POP3 SMTP LDAP) Require SSL/TLS for the connection - often referred…'
complete -c curl -l ssl-revoke-best-effort -d '(TLS) (Schannel) Ignore certificate revocation checks when they failed due to…'
complete -c curl -s 2 -l sslv2 -d '(SSL) This option previously asked curl to use SSLv2, but is now ignored (add…'
complete -c curl -s 3 -l sslv3 -d '(SSL) This option previously asked curl to use SSLv3, but is now ignored (add…'
complete -c curl -l stderr -d 'Redirect all writes to stderr to the specified file instead'
complete -c curl -l styled-output -d 'Enable automatic use of bold font styles when writing HTTP headers to the ter…'
complete -c curl -l suppress-connect-headers -d 'When -p, --proxytunnel is used and a CONNECT request is made do not output pr…'
complete -c curl -l tcp-fastopen -d 'Enable use of TCP Fast Open (RFC 7413)'
complete -c curl -l tcp-nodelay -d 'Turn on the TCP_NODELAY option'
complete -c curl -s t -l telnet-option -d 'Pass options to the telnet protocol.  Supported options are: . RS'
complete -c curl -l tftp-blksize -d '(TFTP) Set the TFTP BLKSIZE option (must be 512 or larger)'
complete -c curl -l tftp-no-options -d '(TFTP) Do not to send TFTP options requests'
complete -c curl -s z -l time-cond -d '(HTTP FTP) Request a file that has been modified later than the given time an…'
complete -c curl -l tls-max -d '(TLS) VERSION defines maximum supported TLS version'
complete -c curl -l tls13-ciphers -d '(TLS) Specifies which cipher suites to use in the connection if it negotiates…'
complete -c curl -l tlsauthtype -d '(TLS) Set TLS authentication type'
complete -c curl -l tlspassword -d '(TLS) Set password to use with the TLS authentication method specified with -…'
complete -c curl -l tlsuser -d '(TLS) Set username for use with the TLS authentication method specified with …'
complete -c curl -l tlsv1 -d '(TLS) Use at least TLS version 1. x when negotiating with a remote TLS server'
complete -c curl -l 'tlsv1.0' -d '(TLS) Forces curl to use TLS version 1'
complete -c curl -l 'tlsv1.1' -d '(TLS) Forces curl to use TLS version 1'
complete -c curl -l 'tlsv1.2' -d '(TLS) Forces curl to use TLS version 1'
complete -c curl -l 'tlsv1.3' -d '(TLS) Forces curl to use TLS version 1'
complete -c curl -l tr-encoding -d '(HTTP) Request a compressed Transfer-Encoding response using one of the algor…'
complete -c curl -l trace -d 'Save a full trace dump of all incoming and outgoing data, including descripti…'
complete -c curl -l trace-ascii -d 'Save a full trace dump of all incoming and outgoing data, including descripti…'
complete -c curl -l trace-config -d 'Set configuration for trace output'
complete -c curl -l trace-ids -d 'Prepends the transfer and connection identifiers to each trace or verbose lin…'
complete -c curl -l trace-time -d 'Prepends a time stamp to each trace or verbose line that curl displays'
complete -c curl -l unix-socket -d '(HTTP) Connect through this Unix domain socket, instead of using the network'
complete -c curl -s T -l upload-file -d 'Upload the specified local file to the remote URL'
complete -c curl -l url -d 'Specify a URL to fetch'
complete -c curl -l url-query -d '(all) Add a piece of data, usually a name + value pair, to the end of the URL…'
complete -c curl -s B -l use-ascii -d '(FTP LDAP) Enable ASCII transfer mode'
complete -c curl -s u -l user -d 'Specify the username and password to use for server authentication'
complete -c curl -s A -l user-agent -d '(HTTP) Specify the User-Agent string to send to the HTTP server'
complete -c curl -l variable -d 'Set a variable with "name=content" or "name@file" (where "file" can be stdin …'
complete -c curl -s v -l verbose -d 'Makes curl verbose during the operation'
complete -c curl -s V -l version -d 'Displays information about curl and the libcurl version it uses'
complete -c curl -l vlan-priority -d '(All) Set VLAN priority as defined in IEEE 802. 1Q'
complete -c curl -s w -l write-out -d 'Make curl display information on stdout after a completed transfer'
complete -c curl -l expand-url -d 'When expanding variables, curl supports a set of functions that can make the …'
complete -c curl -l expand-variable
complete -c curl -l expand-data -d 'https://example. com/ Command line variables and expansions were added in 8'
complete -c curl -l option
complete -c curl -l eprt -l no-eprt -d 'for --disable-eprt'
complete -c curl -l epsv -l no-epsv -d 'for --disable-epsv'
complete -c curl -l clobber -d specified
complete -c curl -l keepalive
complete -c curl -l progress-meter
complete -c curl -l sessionid
complete -c curl -o all
complete -c curl -l no-remote-name
complete -c curl -l xattr -d 'When saving output to a file, tell curl to store file metadata in extended fi…'
