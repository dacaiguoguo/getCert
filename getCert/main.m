//
//  main.m
//  getCert
//
//  Created by yanguo sun on 2024/7/2.
//

#import <Foundation/Foundation.h>


NSURL *getCertAtHost(NSString *host, NSString *outputPath) {
    NSString *logFileName = [host stringByAppendingString:@".cer"];
    NSString *logFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:logFileName];
    if (outputPath) {
        logFilePath = outputPath.stringByStandardizingPath;
    }
    NSArray *commandArray =  @[@"echo | openssl s_client -showcerts -servername ",host, @" -connect ", host, @":443 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ", logFilePath];
    NSString *alllogFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[host stringByAppendingString:@"all.log"]];
    NSArray *allcommandArray =  @[@"echo | openssl s_client -connect ", host, @":443 2>/dev/null > ", alllogFilePath];
    NSString *allcommandString = [allcommandArray componentsJoinedByString:@""];
    system([allcommandString UTF8String]);
    NSString *allContent = [NSString stringWithContentsOfFile:alllogFilePath encoding:NSUTF8StringEncoding error:nil];
    if (![allContent containsString:@"(self signed certificate)"]) {
        NSLog(@"not self signed certificate");
        if (outputPath) {
            NSString *commandString = [commandArray componentsJoinedByString:@""];
            system([commandString UTF8String]);
        }
        exit(1);
    }
//添加自签名证书判断    (self signed certificate)

    NSString *commandString = [commandArray componentsJoinedByString:@""];
    system([commandString UTF8String]);
    NSURL *logFileUrl = [NSURL fileURLWithPath:logFilePath];
    NSLog(@"%@",logFilePath);
    return logFileUrl;
}

NSString *hexStringFromData(NSData* data) {
    const unsigned char *dataBytes = (const unsigned char *)[data bytes];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(data.length * 2)];
    for (NSInteger i = 0; i < data.length; ++i) {
        [hexString appendFormat:@"%02x", dataBytes[i]];
    }
    return [hexString copy];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *host = [NSString stringWithFormat:@"%s",argv[1]];
        if (![host containsString:@"."]) {
            NSLog(@"need host");
            return 0;
        }
        NSString *outputPath = nil;
        if (argc > 2) {
            outputPath = [NSString stringWithFormat:@"%s",argv[2]];
        }
        NSURL *certUrl = getCertAtHost(host, outputPath);

        NSString *logFileName = [host stringByAppendingString:@".log"];
        NSString *logFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:logFileName];

        //转换格式
        NSString *inPath = [[NSString stringWithFormat:@"%@",certUrl] substringFromIndex:7];
        NSString *outPath = [inPath.stringByDeletingPathExtension stringByAppendingPathExtension:@"der"];
        NSString *outform = [NSString stringWithFormat:@"openssl x509 -outform der -in %@ -out %@", inPath, outPath];
        int outformRet = system([outform UTF8String]);
        //获取为hex格式
        NSData *data = [NSData dataWithContentsOfFile:outPath];
        NSString *dataString = hexStringFromData(data);

        //获取sha1
        NSString *sha1 = [NSString stringWithFormat:@"openssl x509 -sha1 -in %@ -noout -fingerprint > %@", inPath, logFilePath];
        outformRet = system([sha1 UTF8String]);
        NSString *sha1Content = [NSString stringWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:nil];
        sha1Content = [sha1Content stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSArray *compArray = [sha1Content componentsSeparatedByString:@"="];
        NSString *sha1Value = compArray.lastObject;
        sha1Value = [[sha1Value componentsSeparatedByString:@":"] componentsJoinedByString:@""];

        //获取subject
        NSString *subject = [NSString stringWithFormat:@"openssl x509 -sha1 -in %@ -noout -subject > %@", inPath, logFilePath];
        outformRet = system([subject UTF8String]);
        NSData *subjectContentData = [NSData dataWithContentsOfFile:logFilePath];
        NSString *subjectContentString = hexStringFromData(subjectContentData);

        //tset为固定值
        NSString *tset = @"3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C21444F435459504520706C697374205055424C494320222D2F2F4170706C652F2F44544420504C49535420312E302F2F454E222022687474703A2F2F7777772E6170706C652E636F6D2F445444732F50726F70657274794C6973742D312E302E647464223E0A3C706C6973742076657273696F6E3D22312E30223E0A3C61727261792F3E0A3C2F706C6973743E0A";

        //执行先删除后插入命令
        NSString *insertCommand = [NSString stringWithFormat:
@"for SQLITEDBPATH in ~/Library/Developer/CoreSimulator/Devices/*/data/Library/Keychains/TrustStore.sqlite3\n\
do\n\
if [ -f \"$SQLITEDBPATH\" ]; then\n\
echo $SQLITEDBPATH\n\
sqlite3 \"$SQLITEDBPATH\" <<EOF\n\
DELETE FROM tsettings WHERE sha1 = X'%@';\n\
EOF\n\
sqlite3 \"$SQLITEDBPATH\" <<EOF\n\
INSERT INTO \"tsettings\" VALUES(X'%@',X'%@',X'%@',X'%@');      \n\
EOF\n\
fi\n\
done", sha1Value, sha1Value, subjectContentString, tset, dataString];
//        NSLog(@"%@",insertCommand);
        outformRet = system([insertCommand UTF8String]);

    }
    return 0;
}
