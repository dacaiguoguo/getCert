#/bin/bash
#
# Installs the Charles Root certificate into the iOS Simulators for the current user.


install() {
if [ -f "$SQLITEDBPATH" ]; then
cp -n "$SQLITEDBPATH" "$SQLITEDBPATH.charlesbackup"
sqlite3 "$SQLITEDBPATH" <<EOF
DELETE FROM tsettings WHERE subj = '44692D2B43E2458197DE96BCAF46301F0DDC56C9';
EOF
sqlite3 "$SQLITEDBPATH" <<EOF
INSERT INTO "tsettings" VALUES(X'44692D2B43E2458197DE96BCAF46301F0DDC56C9',X'7375626a6563743d202f434e3d436861726c65732050726f787920437573746f6d20526f6f7420436572746966696361746520286275696c74206f6e2073756e79616e67756f732d694d61632e6c6f63616c2c2033205c7845355c7839425c7839425c7845365c7839435c7838382032303135292f4f553d687474703a2f2f636861726c657370726f78792e636f6d2f73736c2f4f3d584b3732204c74642f4c3d4175636b6c616e642f53543d4175636b6c616e642f433d4e5a',X'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C21444F435459504520706C697374205055424C494320222D2F2F4170706C652F2F44544420504C49535420312E302F2F454E222022687474703A2F2F7777772E6170706C652E636F6D2F445444732F50726F70657274794C6973742D312E302E647464223E0A3C706C6973742076657273696F6E3D22312E30223E0A3C61727261792F3E0A3C2F706C6973743E0A',X'308203f7308202dfa003020102020900e3cc0240d42efbd1300d06092a864886f70d01010b0500308191310b300906035504061302434e3111300f06035504080c087368616e676861693111300f06035504070c087368616e67686169310f300d060355040a0c066c766d616d61310d300b060355040b0c046c7674753115301306035504030c0c2a2e6c766d616d612e636f6d3125302306092a864886f70d01090116166c7674755f6465706c6f79406c766d616d612e636f6d301e170d3136313032313032323833385a170d3236313031393032323833385a308191310b300906035504061302434e3111300f06035504080c087368616e676861693111300f06035504070c087368616e67686169310f300d060355040a0c066c766d616d61310d300b060355040b0c046c7674753115301306035504030c0c2a2e6c766d616d612e636f6d3125302306092a864886f70d01090116166c7674755f6465706c6f79406c766d616d612e636f6d30820122300d06092a864886f70d01010105000382010f003082010a0282010100a2faedaee40e68d73f7e95b2dd4b80d0909ec165d0a7c3dcfc97af7ae9012fe3601f8fdb664902330c36c72ab67a0447bb0e8aa2786e2bd54c730c94e27d366270917d26c107bc13c28137b6324689d4afa5539ff6528e9541c9c553efe9c8cf6e2b1f2a953363650ec9a3be99676f86efdb7cc176bd7a39d04e0a63596e83888926b9963f3155f689d27539244449899555e390628f3c4632b1f7491047c2f69276d66f7b86346c2bc522442c135778e35caaa9e9bf6191ad3294d4eb52c9dd29f3aaae49f5f781dd85bca52cea7777c056217917de996a1af2e2272e5f1085e42bebe3795d1f523a9d2dd9ed897bb68b137b857054ce23a5caed5b8d6234530203010001a350304e301d0603551d0e04160414b8977497d101049501b970a45bdd9c9e8f51c430301f0603551d23041830168014b8977497d101049501b970a45bdd9c9e8f51c430300c0603551d13040530030101ff300d06092a864886f70d01010b050003820101008a3a6c9a5cf44167962d9ca7b89411506ca02b528a91ae5719147eae08c89b4b6389a0d8a2e06c4a6d2fc496186272a33c7ef8409e6906af5577532e5f8e9254b9deb7555e823e4efacd35ffdaa62a7798327b3ede98a30d03b675ebea64cbd90c42517757464d495aac6406068f6a159d83e7179b4e9a65847339190edcae67fa8f7020182e1766b6202b7e47fcb4cef856d6c30b836377ad26df8618dc52687da8a717e6a53e8ebf08b1df67180f091c16096d276b9d32f2917be38e08822d80bc5d6ec6324350d5e532bd144a16668299a1a6db174b35ebf680324070b5c607917752f000db425cf47ead5cb89ed66dc938a4a2332253fbc59a781eb077df');
EOF
fi
}
#INSERT INTO "tsettings" VALUES(X'44692D2B43E2458197DE96BCAF46301F0DDC56C9',X'7375626a6563743d202f434e3d436861726c65732050726f787920437573746f6d20526f6f7420436572746966696361746520286275696c74206f6e2073756e79616e67756f732d694d61632e6c6f63616c2c2033205c7845355c7839425c7839425c7845365c7839435c7838382032303135292f4f553d687474703a2f2f636861726c657370726f78792e636f6d2f73736c2f4f3d584b3732204c74642f4c3d4175636b6c616e642f53543d4175636b6c616e642f433d4e5a',X'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C21444F435459504520706C697374205055424C494320222D2F2F4170706C652F2F44544420504C49535420312E302F2F454E222022687474703A2F2F7777772E6170706C652E636F6D2F445444732F50726F70657274794C6973742D312E302E647464223E0A3C706C6973742076657273696F6E3D22312E30223E0A3C61727261792F3E0A3C2F706C6973743E0A',X'308203f7308202dfa003020102020900e3cc0240d42efbd1300d06092a864886f70d01010b0500308191310b300906035504061302434e3111300f06035504080c087368616e676861693111300f06035504070c087368616e67686169310f300d060355040a0c066c766d616d61310d300b060355040b0c046c7674753115301306035504030c0c2a2e6c766d616d612e636f6d3125302306092a864886f70d01090116166c7674755f6465706c6f79406c766d616d612e636f6d301e170d3136313032313032323833385a170d3236313031393032323833385a308191310b300906035504061302434e3111300f06035504080c087368616e676861693111300f06035504070c087368616e67686169310f300d060355040a0c066c766d616d61310d300b060355040b0c046c7674753115301306035504030c0c2a2e6c766d616d612e636f6d3125302306092a864886f70d01090116166c7674755f6465706c6f79406c766d616d612e636f6d30820122300d06092a864886f70d01010105000382010f003082010a0282010100a2faedaee40e68d73f7e95b2dd4b80d0909ec165d0a7c3dcfc97af7ae9012fe3601f8fdb664902330c36c72ab67a0447bb0e8aa2786e2bd54c730c94e27d366270917d26c107bc13c28137b6324689d4afa5539ff6528e9541c9c553efe9c8cf6e2b1f2a953363650ec9a3be99676f86efdb7cc176bd7a39d04e0a63596e83888926b9963f3155f689d27539244449899555e390628f3c4632b1f7491047c2f69276d66f7b86346c2bc522442c135778e35caaa9e9bf6191ad3294d4eb52c9dd29f3aaae49f5f781dd85bca52cea7777c056217917de996a1af2e2272e5f1085e42bebe3795d1f523a9d2dd9ed897bb68b137b857054ce23a5caed5b8d6234530203010001a350304e301d0603551d0e04160414b8977497d101049501b970a45bdd9c9e8f51c430301f0603551d23041830168014b8977497d101049501b970a45bdd9c9e8f51c430300c0603551d13040530030101ff300d06092a864886f70d01010b050003820101008a3a6c9a5cf44167962d9ca7b89411506ca02b528a91ae5719147eae08c89b4b6389a0d8a2e06c4a6d2fc496186272a33c7ef8409e6906af5577532e5f8e9254b9deb7555e823e4efacd35ffdaa62a7798327b3ede98a30d03b675ebea64cbd90c42517757464d495aac6406068f6a159d83e7179b4e9a65847339190edcae67fa8f7020182e1766b6202b7e47fcb4cef856d6c30b836377ad26df8618dc52687da8a717e6a53e8ebf08b1df67180f091c16096d276b9d32f2917be38e08822d80bc5d6ec6324350d5e532bd144a16668299a1a6db174b35ebf680324070b5c607917752f000db425cf47ead5cb89ed66dc938a4a2332253fbc59a781eb077df');
#DELETE FROM tsettings WHERE subj = X'44692D2B43E2458197DE96BCAF46301F0DDC56C9'

for SQLITEDBPATH in ~/Library/Application\ Support/iPhone\ Simulator/3.*/Library/Keychains/TrustStore.sqlite3
do install
done

for SQLITEDBPATH in ~/Library/Application\ Support/iPhone\ Simulator/4.*/Library/Keychains/TrustStore.sqlite3
do install
done

for SQLITEDBPATH in ~/Library/Developer/CoreSimulator/Devices/*/data/Library/Keychains/TrustStore.sqlite3
do install
done

SQLITEDBPATH=~/Library/Application\ Support/iPhone\ Simulator/User/Library/Keychains/TrustStore.sqlite3
install

echo "The Charles Root Certificate has been installed for the iPhone Simulator"