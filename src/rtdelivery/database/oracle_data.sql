
-- JAVA 11 PLUS excluding debuginfo delivery_file
INSERT INTO "file_pattern" VALUES('modular_oracle','{sdk_type}-(.*?)_{platform}_bin.{file_type}');

INSERT INTO "files" VALUES(null,'oracle','java','jdk',':17.0:11.0','x64_linux','jdk-(.*?)_linux-x64_bin.rpm',':jim','','','0');
INSERT INTO "files" VALUES(null,'oracle','java','jdk',':17.0:11.0','aarch64_mac','jdk-(.*?)_macos-aarch64_bin.dmg',':jim','','','0');
INSERT INTO "files" VALUES(null,'oracle','java','jdk',':17.0','x64_mac','jdk-(.*?)_macos-x64_bin.dmg',':jim','','','0');
INSERT INTO "files" VALUES(null,'oracle','java','jdk',':11.0','x64_mac','jdk-(.*?)_os-x64_bin.dmg',':jim','','','0');
INSERT INTO "files" VALUES(null,'oracle','java','jdk',':11.0','sparcv9_solaris','jdk-(.*?)_solaris-sparcv9_bin.tar.gz',':jim','','','0');
INSERT INTO "files" VALUES(null,'oracle','java','jdk',':17.0:11.0','x64_windows','jdk-(.*?)_windows-x64_bin.exe',':jim','','','0');
INSERT INTO "files" VALUES(null,'oracle','java','jdk',':17.0:11.0','x64_windows','jdk-(.*?)_windows-x64_bin.zip',':jim','','','0');


INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','macos-aarch64','dmg');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','macos-x64','dmg');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','solaris-sparcv9','tar.gz');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','windows-x64','exe');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','windows-x64','zip');

INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','linux-x64','rpm');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','macos-aarch64','dmg');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','os-x64','dmg');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','solaris-sparcv9','tar.gz');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','windows-x64','exe');
INSERT INTO "Delivery_release" VALUES('oracle','17.0','modular_oracle','jdk','windows-x64','zip');

-- JAVA 8 and 7 excluding debuginfo delivery_file
INSERT INTO "file_pattern" VALUES('legacy_oracle','{sdk_type}-(.*?)-{platform}-(.[^-]*?).{file_type}');

INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','linux-aarch64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','linux-x64','rpm');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','linux-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','linux-i586','rpm');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','linux-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','macosx-x64','dmg');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','macosx-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','solaris-sparcv9','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','solaris-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','windows-i586','exe');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','windows-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','windows-x64','exe');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jdk','windows-x64','tar.gz');

INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','linux-i586','rpm');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','linux-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','linux-x64','rpm');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','linux-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','macosx-x64','dmg');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','macosx-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','solaris-sparcv9','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','solaris-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','windows-i586','exe');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','jre','windows-x64','exe');

INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','server-jre','windows-x64','exe');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','server-jre','solaris-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','server-jre','solaris-sparcv9','tar.gz');
INSERT INTO "delivery_file" VALUES('8.0','legacy_oracle','server-jre','linux-x64','rpm');


INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','linux-x64','rpm');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','linux-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','linux-i586','rpm');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','linux-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','macosx-x64','dmg');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','macosx-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','solaris-sparcv9','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','solaris-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','solaris-sparc','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','solaris-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','windows-i586','exe');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','windows-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','windows-x64','exe');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jdk','windows-x64','tar.gz');

INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','linux-i586','rpm');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','linux-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','linux-x64','rpm');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','linux-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','macosx-x64','dmg');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','macosx-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','solaris-sparcv9','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','solaris-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','solaris-sparc','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','solaris-i586','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','windows-i586','exe');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','jre','windows-x64','exe');

INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','server-jre','windows-x64','exe');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','server-jre','solaris-x64','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','server-jre','solaris-sparcv9','tar.gz');
INSERT INTO "delivery_file" VALUES('7.0','legacy_oracle','server-jre','linux-x64','rpm');


-- File patterns for IBM Java
INSERT INTO "file_pattern" VALUES('ibm_legacy_sdk','{platform}(.*?)-sdk.{file_type}');
INSERT INTO "file_pattern" VALUES('ibm_legacy_jre','{platform}(.*?)-jre.{file_type}');
INSERT INTO "file_pattern" VALUES('ibm_legacy_jre_sha','(.*?)-JavaSE-JRE-{platform}.{file_type}');
INSERT INTO "file_pattern" VALUES('ibm_legacy_sdk_sha','(.*?)-JavaSE-JDK-{platform}.{file_type}');
INSERT INTO "file_pattern" VALUES('ibm_legacy_32redist_bin','{sdk_type}(.*?)32redist.{file_type}');
INSERT INTO "file_pattern" VALUES('ibm_legacy_32ia_bin','java(.*?)_32_{sdk_type}_installanywhere_redist.{file_type}');
INSERT INTO "file_pattern" VALUES('ibm_legacy_32im_bin','ibm-java-{sdk_type}-(.*?)-{platform}-installmgr.{file_type}');



INSERT INTO "files" VALUES(112800101,'ibm'':7.1:8.0','all_all','ibm-java-sdk-(.*?)-dist-capilano.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800102,'ibm'':7.1:8.0','all_all','ibm-java-sdk-(.*?)-all-prt1-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800104,'ibm'':7.1:8.0','all_all','ibm-java-sdk-(.*?)-all-prt2-installmgr.zip',':iman','','2','');
INSERT INTO "files" VALUES(112800106,'ibm'':8.0','all_all','ibm-java-sdk-(.*?)-all-prt3-installmgr.zip',':iman','','3','');
INSERT INTO "files" VALUES(112800108,'ibm'':7.1','all_all','(.*?)-JavaSE-SDK-all-platforms-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-all-prt1-installmgr.zip,ibm-java-sdk-(.*?)-all-prt2-installmgr.zip','3','');
INSERT INTO "files" VALUES(112800109,'ibm'':8.0','all_all','(.*?)-JavaSE-SDK-all-platforms-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-all-prt1-installmgr.zip,ibm-java-sdk-(.*?)-all-prt2-installmgr.zip,ibm-java-sdk-(.*?)-all-prt3-installmgr.zip','4','');

INSERT INTO "files" VALUES(112800201,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_32ia_bin','sdk','','bin',':fc','','3','');
INSERT INTO "files" VALUES(112800203,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_32redist_bin','j','','tar.gz',':fhd:jim','','1','1');
INSERT INTO "files" VALUES(112800205,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_sdk_sha','AIXpSeries32','sha256.txt',':fhd','j(.*?)32redist.tar.gz','2','');
INSERT INTO "files" VALUES(112800206,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_sdk','pap32','jar',':jim','','','2');
INSERT INTO "files" VALUES(112800208,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_sdk','pap32','tar.Z',':test','','','');
INSERT INTO "files" VALUES(112800210,'ibm'':7.1:8.0','ppc_aix','ibm_legacy_32im_bin','sdk','aix-ppc','zip',':iman','','1','');
INSERT INTO "files" VALUES(112800212,'ibm'':7.1:8.0','ppc_aix','ibm_legacy_sdk_sha','aix-ppc-installmgr','sha256.txt',':iman','ibm-java-sdk-(.*?)-aix-ppc-installmgr.zip','2','');
INSERT INTO "files" VALUES(112800213,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_32ia_bin','jre','','bin',':fc','','4','');
INSERT INTO "files" VALUES(112800215,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_32redist_bin','jre','','tar.gz',':fhd:jim','','1','3');
INSERT INTO "files" VALUES(112800217,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_jre_sha','AIXpSeries32','sha256.txt',':fhd','jre(.*?)32redist.tar.gz','2','');
INSERT INTO "files" VALUES(112800218,'ibm'':7.0:7.1:8.0','ppc_aix','ibm_legacy_jre','pap32','jar',':jim','','','4');

INSERT INTO "files" VALUES(112800301,'ibm'':7.0:7.1:8.0','ppc64_aix','java(.*?)_64_sdk_installanywhere_redist.bin',':fc','','3','');
INSERT INTO "files" VALUES(112800303,'ibm'':7.0:7.1:8.0','ppc64_aix','j(.*?)64redist.tar.gz',':fhd:jim','','1','1');
INSERT INTO "files" VALUES(112800305,'ibm'':7.0:7.1:8.0','ppc64_aix','ibm_legacy_sdk_sha','AIXpSeries64','sha256.txt',':fhd','j(.*?)64redist.tar.gz','2','');
INSERT INTO "files" VALUES(112800306,'ibm'':7.0:7.1:8.0','ppc64_aix','pap64(.*?)-sdk.jar',':jim','','','2');
INSERT INTO "files" VALUES(112800308,'ibm'':7.0:7.1:8.0','ppc64_aix','pap64(.*?)-sdk.tar.Z',':test','','','');
INSERT INTO "files" VALUES(112800310,'ibm'':7.1:8.0','ppc64_aix','ibm-java-sdk-(.*?)-aix-ppc64-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800312,'ibm'':7.1:8.0','ppc64_aix','(.*?)-JavaSE-SDK-aix-ppc64-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-aix-ppc64-installmgr.zip','2','');
INSERT INTO "files" VALUES(112800313,'ibm'':7.0:7.1:8.0','ppc64_aix','java(.*?)_64_jre_installanywhere_redist.bin',':fc','','4','');
INSERT INTO "files" VALUES(112800315,'ibm'':7.0:7.1:8.0','ppc64_aix','jre(.*?)64redist.tar.gz',':fhd:jim','','1','3');
INSERT INTO "files" VALUES(112800317,'ibm'':7.0:7.1:8.0','ppc64_aix',,'ibm_legacy_jre_sha','AIXpSeries64','sha256.txt',':fhd','jre(.*?)64redist.tar.gz','2','');
INSERT INTO "files" VALUES(112800318,'ibm'':7.0:7.1:8.0','ppc64_aix','pap64(.*?)-jre.jar',':jim','','','4');

INSERT INTO "files" VALUES(112800401,'ibm'':7.0:7.1:8.0','s390_zos','SDK(.*?).PAX.Z',':jim','','','1');
INSERT INTO "files" VALUES(112800402,'ibm'':7.0:7.1:8.0','s390_zos','SDK(.*?)_31bit_readme.txt',':jim','','','2');
INSERT INTO "files" VALUES(112800403,'ibm'':7.0:7.1:8.0','s390_zos','pmz31(.*?)-sdk.pax.Z',':test','','','');
INSERT INTO "files" VALUES(112800404,'ibm'':7.1:8.0','s390_zos','ibm-java-sdk-(.*?)-zos-s390-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800406,'ibm'':7.1:8.0','s390_zos','(.*?)-JavaSE-SDK-zos-s390-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-zos-s390-installmgr.zip','2','');
INSERT INTO "files" VALUES(112800501,'ibm'':7.0:7.1:8.0','s390x_zos','SDK(.*?).PAX.Z',':jim','','','1');
INSERT INTO "files" VALUES(112800502,'ibm'':7.0:7.1:8.0','s390x_zos','SDK(.*?)_64bit_readme.txt',':jim','','','2');
INSERT INTO "files" VALUES(112800503,'ibm'':7.0:7.1:8.0','s390x_zos','pmz64(.*?)-sdk.pax.Z',':test','','','');
INSERT INTO "files" VALUES(112800504,'ibm'':7.1:8.0','s390x_zos','ibm-java-sdk-(.*?)-zos-s390x-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800506,'ibm'':7.1:8.0','s390x_zos','(.*?)-JavaSE-SDK-zos-s390x-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-zos-s390x-installmgr.zip','2','');

INSERT INTO "files" VALUES(112800601,'ibm'':7.0:7.1:8.0','x64_windows','ibm-java-sdk-(.*?)-win-x86_64.exe',':jim','','','1');
INSERT INTO "files" VALUES(112800602,'ibm'':7.0:7.1:8.0','x64_windows','ibm-java-sdk-(.*?)-win-x86_64.zip',':test:fhd:jim:oem','','1','2');
INSERT INTO "files" VALUES(112800603,'ibm'':7.0:7.1:8.0','x64_windows','(.*?)-JavaSE-SDK-Windowsx8664.sha256.txt',':fhd','ibm-java-sdk-(.*?)-win-x86_64.zip','2','');
INSERT INTO "files" VALUES(112800604,'ibm'':7.1:8.0','x64_windows','ibm-java-sdk-(.*?)-win-x64-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800606,'ibm'':7.1:8.0','x64_windows','(.*?)-JavaSE-SDK-win-x64-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-win-x64-installmgr.zip','2','');
INSERT INTO "files" VALUES(112800607,'ibm'':7.0:7.1:8.0','x64_windows','ibm-java-jre-(.*?)-win-x86_64.exe',':jim','','','3');
INSERT INTO "files" VALUES(112800608,'ibm'':7.0:7.1:8.0','x64_windows','ibm-java-jre-(.*?)-win-x86_64.zip',':fhd:jim:oem','','1','4');
INSERT INTO "files" VALUES(112800609,'ibm'':7.0:7.1:8.0','x64_windows','(.*?)-JavaSE-JRE-Windowsx8664.sha256.txt',':fhd','ibm-java-jre-(.*?)-win-x86_64.zip','2','');
INSERT INTO "files" VALUES(112800701,'ibm'':7.0:7.1:8.0','x32_windows','ibm-java-sdk-(.*?)-win-i386.exe',':jim','','','1');
INSERT INTO "files" VALUES(112800702,'ibm'':7.0:7.1:8.0','x32_windows','ibm-java-sdk-(.*?)-win-i386.zip',':test:fhd:jim:oem','','1','2');
INSERT INTO "files" VALUES(112800703,'ibm'':7.0:7.1:8.0','x32_windows','(.*?)-JavaSE-SDK-Windowsx8632.sha256.txt',':fhd','ibm-java-sdk-(.*?)-win-i386.zip','2','');
INSERT INTO "files" VALUES(112800704,'ibm'':7.1:8.0','x32_windows','ibm-java-sdk-(.*?)-win-x86-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800706,'ibm'':7.1:8.0','x32_windows','(.*?)-JavaSE-SDK-win-x86-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-win-x86-installmgr.zip','2','');
INSERT INTO "files" VALUES(112800707,'ibm'':7.0:7.1:8.0','x32_windows','ibm-java-jre-(.*?)-win-i386.exe',':jim','','','3');
INSERT INTO "files" VALUES(112800708,'ibm'':7.0:7.1:8.0','x32_windows','ibm-java-jre-(.*?)-win-i386.zip',':fhd:jim:oem','','1','4');
INSERT INTO "files" VALUES(112800709,'ibm'':7.0:7.1:8.0','x32_windows','(.*?)-JavaSE-JRE-Windowsx8632.sha256.txt',':fhd','ibm-java-jre-(.*?)-win-i386.zip','2','');

INSERT INTO "files" VALUES(112800801,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-x86_64-sdk-(.*?).x86_64.rpm',':jim','','','1');
INSERT INTO "files" VALUES(112800802,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-x86_64-sdk-(.*?).bin',':fc:is','','1','');
INSERT INTO "files" VALUES(112800804,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-sdk-(.*?)-x86_64-archive.bin',':fc:is','','3','');
INSERT INTO "files" VALUES(112800806,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-sdk-(.*?)-linux-x86_64.tgz',':test:fhd:jim','','1','2');
INSERT INTO "files" VALUES(112800808,'ibm'':7.0:7.1:8.0','x64_linux','(.*?)-JavaSE-SDK-Linuxx86_6464.sha256.txt',':fhd','ibm-java-sdk-(.*?)-linux-x86_64.tgz','2','');
INSERT INTO "files" VALUES(112800809,'ibm'':7.1:8.0','x64_linux','ibm-java-sdk-(.*?)-linux-x64-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800811,'ibm'':7.1:8.0','x64_linux','(.*?)-JavaSE-SDK-linux-x64-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-linux-x64-installmgr.zip','2','');
INSERT INTO "files" VALUES(112800812,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-x86_64-jre-(.*?).x86_64.rpm',':jim','','','3');
INSERT INTO "files" VALUES(112800813,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-x86_64-jre-(.*?).bin',':fc:is','','2','');
INSERT INTO "files" VALUES(112800815,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-jre-(.*?)-x86_64-archive.bin',':fc:is','','4','');
INSERT INTO "files" VALUES(112800817,'ibm'':7.0:7.1:8.0','x64_linux','ibm-java-jre-(.*?)-linux-x86_64.tgz',':fhd:jim','','1','4');
INSERT INTO "files" VALUES(112800819,'ibm'':7.0:7.1:8.0','x64_linux','(.*?)-JavaSE-JRE-Linuxx86_6464.sha256.txt',':fhd','ibm-java-jre-(.*?)-linux-x86_64.tgz','2','');
INSERT INTO "files" VALUES(112800820,'ibm'':8.0','x64_linux','ibm-java-sfj-(.*?)-x86_64-archive.bin',':is','','','');
INSERT INTO "files" VALUES(112800822,'ibm'':7.1:8.0','x64_linux','pxa64(.*?)-cloud.tgz',':jim','','','1');

INSERT INTO "files" VALUES(112800901,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-i386-sdk-(.*?).i386.rpm',':jim','','','2');
INSERT INTO "files" VALUES(112800902,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-i386-sdk-(.*?).bin',':fc:is','','1','');
INSERT INTO "files" VALUES(112800904,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-sdk-(.*?)-i386-archive.bin',':fc:is','','3','');
INSERT INTO "files" VALUES(112800906,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-sdk-(.*?)-linux-i386.tgz',':test:fhd:jim','','1','2');
INSERT INTO "files" VALUES(112800908,'ibm'':7.0:7.1:8.0','x32_linux','(.*?)-JavaSE-SDK-Linuxx8632.sha256.txt',':fhd','ibm-java-sdk-(.*?)-linux-i386.tgz','2','');
INSERT INTO "files" VALUES(112800909,'ibm'':7.1:8.0','x32_linux','ibm-java-sdk-(.*?)-linux-x86-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112800911,'ibm'':7.1:8.0','x32_linux','(.*?)-JavaSE-SDK-linux-x86-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-linux-x86-installmgr.zip','2','');
INSERT INTO "files" VALUES(112800912,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-i386-jre-(.*?).i386.rpm',':jim','','','3');
INSERT INTO "files" VALUES(112800913,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-i386-jre-(.*?).bin',':fc:is','','2','');
INSERT INTO "files" VALUES(112800915,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-jre-(.*?)-i386-archive.bin',':fc:is','','4','');
INSERT INTO "files" VALUES(112800917,'ibm'':7.0:7.1:8.0','x32_linux','ibm-java-jre-(.*?)-linux-i386.tgz',':fhd:jim','','1','4');
INSERT INTO "files" VALUES(112800919,'ibm'':7.0:7.1:8.0','x32_linux','(.*?)-JavaSE-JRE-Linuxx8632.sha256.txt',':fhd','ibm-java-jre-(.*?)-linux-i386.tgz','2','');
INSERT INTO "files" VALUES(112800920,'ibm'':8.0','x32_linux','ibm-java-sfj-(.*?)-i386-archive.bin',':is','','','');

INSERT INTO "files" VALUES(112801001,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-ppc64le-sdk-(.*?).ppc64le.rpm',':jim','','','1');
INSERT INTO "files" VALUES(112801002,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-ppc64le-sdk-(.*?).bin',':fc:is','','1','');
INSERT INTO "files" VALUES(112801004,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-sdk-(.*?)-ppc64le-archive.bin',':fc:is','','3','');
INSERT INTO "files" VALUES(112801006,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-sdk-(.*?)-linux-ppc64le.tgz',':test:fhd:jim','','1','2');
INSERT INTO "files" VALUES(112801008,'ibm'':7.1:8.0','ppc64le_linux','(.*?)-JavaSE-SDK-LinuxpSeries64le.sha256.txt',':fhd','ibm-java-sdk-(.*?)-linux-ppc64le.tgz','2','');
INSERT INTO "files" VALUES(112801009,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-sdk-(.*?)-linux-ppc64le-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112801011,'ibm'':7.1:8.0','ppc64le_linux','(.*?)-JavaSE-SDK-linux-ppc64le-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-linux-ppc64le-installmgr.zip','2','');
INSERT INTO "files" VALUES(112801012,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-ppc64le-jre-(.*?).ppc64le.rpm',':jim','','','3');
INSERT INTO "files" VALUES(112801013,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-ppc64le-jre-(.*?).bin',':fc:is','','2','');
INSERT INTO "files" VALUES(112801015,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-jre-(.*?)-ppc64le-archive.bin',':fc:is','','4','');
INSERT INTO "files" VALUES(112801017,'ibm'':7.1:8.0','ppc64le_linux','ibm-java-jre-(.*?)-linux-ppc64le.tgz',':fhd:jim','','1','4');
INSERT INTO "files" VALUES(112801019,'ibm'':7.1:8.0','ppc64le_linux','(.*?)-JavaSE-JRE-LinuxpSeries64le.sha256.txt',':fhd','ibm-java-jre-(.*?)-linux-ppc64le.tgz','2','');
INSERT INTO "files" VALUES(112801020,'ibm'':8.0','ppc64le_linux','ibm-java-sfj-(.*?)-ppc64le-archive.bin',':is','','','');

INSERT INTO "files" VALUES(112801101,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-ppc-sdk-(.*?).ppc.rpm',':jim','','','1');
INSERT INTO "files" VALUES(112801102,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-ppc-sdk-(.*?).bin',':fc:is','','1','');
INSERT INTO "files" VALUES(112801104,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-sdk-(.*?)-ppc-archive.bin',':fc:is','','3','');
INSERT INTO "files" VALUES(112801106,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-sdk-(.*?)-linux-ppc.tgz',':test:fhd:jim','','1','2');
INSERT INTO "files" VALUES(112801108,'ibm'':7.0:7.1:8.0','ppc_linux','(.*?)-JavaSE-SDK-LinuxpSeries32.sha256.txt',':fhd','ibm-java-sdk-(.*?)-linux-ppc.tgz','2','');
INSERT INTO "files" VALUES(112801109,'ibm'':7.1:8.0','ppc_linux','ibm-java-sdk-(.*?)-linux-ppc-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112801111,'ibm'':7.1:8.0','ppc_linux','(.*?)-JavaSE-SDK-linux-ppc-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-linux-ppc-installmgr.zip','2','');
INSERT INTO "files" VALUES(112801112,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-ppc-jre-(.*?).ppc.rpm',':jim','','','3');
INSERT INTO "files" VALUES(112801113,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-ppc-jre-(.*?).bin',':fc:is','','2','');
INSERT INTO "files" VALUES(112801115,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-jre-(.*?)-ppc-archive.bin',':fc:is','','4','');
INSERT INTO "files" VALUES(112801117,'ibm'':7.0:7.1:8.0','ppc_linux','ibm-java-jre-(.*?)-linux-ppc.tgz',':fhd:jim','','1','4');
INSERT INTO "files" VALUES(112801119,'ibm'':7.0:7.1:8.0','ppc_linux','(.*?)-JavaSE-JRE-LinuxpSeries32.sha256.txt',':fhd','ibm-java-jre-(.*?)-linux-ppc.tgz','2','');

INSERT INTO "files" VALUES(112801201,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-ppc64-sdk-(.*?).ppc64.rpm',':jim','','','1');
INSERT INTO "files" VALUES(112801202,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-ppc64-sdk-(.*?).bin',':fc:is','','1','');
INSERT INTO "files" VALUES(112801204,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-sdk-(.*?)-ppc64-archive.bin',':fc:is','','3','');
INSERT INTO "files" VALUES(112801206,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-sdk-(.*?)-linux-ppc64.tgz',':test:fhd:jim','','1','2');
INSERT INTO "files" VALUES(112801208,'ibm'':7.0:7.1:8.0','ppc64_linux','(.*?)-JavaSE-SDK-LinuxpSeries64.sha256.txt',':fhd','ibm-java-sdk-(.*?)-linux-ppc64.tgz','2','');
INSERT INTO "files" VALUES(112801209,'ibm'':7.1:8.0','ppc64_linux','ibm-java-sdk-(.*?)-linux-ppc64-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112801211,'ibm'':7.1:8.0','ppc64_linux','(.*?)-JavaSE-SDK-linux-ppc64-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-linux-ppc64-installmgr.zip','2','');
INSERT INTO "files" VALUES(112801212,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-ppc64-jre-(.*?).ppc64.rpm',':jim','','','3');
INSERT INTO "files" VALUES(112801213,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-ppc64-jre-(.*?).bin',':fc:is','','2','');
INSERT INTO "files" VALUES(112801215,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-jre-(.*?)-ppc64-archive.bin',':fc:is','','4','');
INSERT INTO "files" VALUES(112801217,'ibm'':7.0:7.1:8.0','ppc64_linux','ibm-java-jre-(.*?)-linux-ppc64.tgz',':fhd:jim','','1','4');
INSERT INTO "files" VALUES(112801219,'ibm'':7.0:7.1:8.0','ppc64_linux','(.*?)-JavaSE-JRE-LinuxpSeries64.sha256.txt',':fhd','ibm-java-jre-(.*?)-linux-ppc64.tgz','2','');

INSERT INTO "files" VALUES(112801501,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-s390-sdk-(.*?).s390.rpm',':jim','','','1');
INSERT INTO "files" VALUES(112801502,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-s390-sdk-(.*?).bin',':fc:is','','1','');
INSERT INTO "files" VALUES(112801504,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-sdk-(.*?)-s390-archive.bin',':fc:is','','3','');
INSERT INTO "files" VALUES(112801506,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-sdk-(.*?)-linux-s390.tgz',':test:fhd:jim','','1','2');
INSERT INTO "files" VALUES(112801508,'ibm'':7.0:7.1:8.0','s390_linux','(.*?)-JavaSE-SDK-LinuxzSeries31.sha256.txt',':fhd','ibm-java-sdk-(.*?)-linux-s390.tgz','2','');
INSERT INTO "files" VALUES(112801509,'ibm'':7.1:8.0','s390_linux','ibm-java-sdk-(.*?)-linux-s390-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112801511,'ibm'':7.1:8.0','s390_linux','(.*?)-JavaSE-SDK-linux-s390-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-linux-s390-installmgr.zip','2','');
INSERT INTO "files" VALUES(112801512,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-s390-jre-(.*?).s390.rpm',':jim','','','3');
INSERT INTO "files" VALUES(112801513,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-s390-jre-(.*?).bin',':fc:is','','2','');
INSERT INTO "files" VALUES(112801515,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-jre-(.*?)-s390-archive.bin',':fc:is','','4','');
INSERT INTO "files" VALUES(112801517,'ibm'':7.0:7.1:8.0','s390_linux','ibm-java-jre-(.*?)-linux-s390.tgz',':fhd:jim','','1','4');
INSERT INTO "files" VALUES(112801519,'ibm'':7.0:7.1:8.0','s390_linux','(.*?)-JavaSE-JRE-LinuxzSeries31.sha256.txt',':fhd','ibm-java-jre-(.*?)-linux-s390.tgz','2','');
INSERT INTO "files" VALUES(112801520,'ibm'':8.0','s390_linux','ibm-java-sfj-(.*?)-s390-archive.bin',':is','','','');

INSERT INTO "files" VALUES(112801601,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-s390x-sdk-(.*?).s390x.rpm',':jim','','','1');
INSERT INTO "files" VALUES(112801602,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-s390x-sdk-(.*?).bin',':fc:is','','1','');
INSERT INTO "files" VALUES(112801604,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-sdk-(.*?)-s390x-archive.bin',':fc:is','','3','');
INSERT INTO "files" VALUES(112801606,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-sdk-(.*?)-linux-s390x.tgz',':test:fhd:jim','','1','2');
INSERT INTO "files" VALUES(112801608,'ibm'':7.0:7.1:8.0','s390x_linux','(.*?)-JavaSE-SDK-LinuxzSeries64.sha256.txt',':fhd','ibm-java-sdk-(.*?)-linux-s390x.tgz','2','');
INSERT INTO "files" VALUES(112801609,'ibm'':7.1:8.0','s390x_linux','ibm-java-sdk-(.*?)-linux-s390x-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112801611,'ibm'':7.1:8.0','s390x_linux','(.*?)-JavaSE-SDK-linux-s390x-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-linux-s390x-installmgr.zip','2','');
INSERT INTO "files" VALUES(112801612,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-s390x-jre-(.*?).s390x.rpm',':jim','','','3');
INSERT INTO "files" VALUES(112801613,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-s390x-jre-(.*?).bin',':fc:is','','2','');
INSERT INTO "files" VALUES(112801615,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-jre-(.*?)-s390x-archive.bin',':fc:is','','4','');
INSERT INTO "files" VALUES(112801617,'ibm'':7.0:7.1:8.0','s390x_linux','ibm-java-jre-(.*?)-linux-s390x.tgz',':fhd:jim','','1','4');
INSERT INTO "files" VALUES(112801619,'ibm'':7.0:7.1:8.0','s390x_linux','(.*?)-JavaSE-JRE-LinuxzSeries64.sha256.txt',':fhd','ibm-java-jre-(.*?)-linux-s390x.tgz','2','');
INSERT INTO "files" VALUES(112801620,'ibm'':8.0','s390x_linux','ibm-java-sfj-(.*?)-s390x-archive.bin',':is','','','');





INSERT INTO "files" VALUES(112801701,'ibm'':7.0:8.0','itanium32_hpux','ibm_legacy_sdk','hpia32','tar.Z',':test:jim:oem','','','1');
INSERT INTO "files" VALUES(112801702,'ibm'':7.0:8.0','itanium32_hpux','ibm_legacy_sdk','hpia32','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112801703,'ibm'':7.0:8.0','itanium32_hpux','ibm_legacy_sdk_sha','HPUXIA32','sha256.txt',':fhd','hpia32(.*?)-sdk.tar.Z','2','');
INSERT INTO "files" VALUES(112801704,'ibm'':7.0:8.0','itanium32_hpux','ibm_legacy_jre','hpia32','tar.Z',':jim:oem','','','2');
INSERT INTO "files" VALUES(112801705,'ibm'':7.0:8.0','itanium32_hpux','ibm_legacy_jre','hpia32','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112801706,'ibm'':7.0:8.0','itanium32_hpux','ibm_legacy_jre_sha','HPUXIA32.sha256.txt',':fhd','hpia32(.*?)-jre.tar.Z','2','');
INSERT INTO "files" VALUES(112801801,'ibm'':7.0:8.0','itanium64_hpux','ibm_legacy_sdk','hpia64','tar.Z',':test:jim:oem','','','1');
INSERT INTO "files" VALUES(112801802,'ibm'':7.0:8.0','itanium64_hpux','ibm_legacy_sdk','hpia64','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112801803,'ibm'':7.0:8.0','itanium64_hpux','ibm_legacy_sdk_sha','HPUXIA64.sha256.txt',':fhd','hpia64(.*?)-sdk.tar.Z','2','');
INSERT INTO "files" VALUES(112801804,'ibm'':7.0:8.0','itanium64_hpux','ibm_legacy_jre','hpia64','tar.Z',':jim:oem','','','2');
INSERT INTO "files" VALUES(112801805,'ibm'':7.0:8.0','itanium64_hpux','ibm_legacy_jre','hpia64','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112801806,'ibm'':7.0:8.0','itanium64_hpux','ibm_legacy_jre_sha','HPUXIA64.sha256.txt',':fhd','hpia64(.*?)-jre.tar.Z','2','');
INSERT INTO "files" VALUES(112801807,'ibm'':8.0','itanium64_hpux','ibm-java-sdk-(.*?)-hpux-ia64-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112801809,'ibm'':8.0','itanium64_hpux','(.*?)-JavaSE-SDK-hpux-ia64-installmgr.sha256.txt',':iman','ibm-java-sdk-(.*?)-hpux-ia64-installmgr.zip','2','');

INSERT INTO "files" VALUES(112802101,'ibm'':8.0','x64_mac','ibm_legacy_sdk','macosxx64','tar.Z',':test:jim:oem','','','1');
INSERT INTO "files" VALUES(112802102,'ibm'':8.0','x64_mac','ibm_legacy_sdk','macosxx64(','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802103,'ibm'':8.0','x64_mac','ibm_legacy_sdk_sha','MacOSXx8664','sha256.txt',':fhd','macosxx64(.*?)-sdk.tar.Z','2','');
INSERT INTO "files" VALUES(112802104,'ibm'':8.0','x64_mac','ibm_legacy_sdk','macosxx64','tar.Z',':jim:oem','','','2');
INSERT INTO "files" VALUES(112802105,'ibm'':8.0','x64_mac','ibm_legacy_sdk','macosxx64','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802106,'ibm'':8.0','x64_mac','ibm_legacy_jre_sha','MacOSXx8664','sha256.txt',':fhd','macosxx64(.*?)-jre.tar.Z','2','');
INSERT INTO "files" VALUES(112802107,'ibm'':8.0','x64_mac','ibm_legacy_sdk','macosxx64','tar.gz',':jim:oem','','','3');
INSERT INTO "files" VALUES(112802108,'ibm'':8.0','x64_mac','ibm_legacy_sdk','ibm-java-sdk-(.*?)-darwin-x64-installmgr.zip',':iman','','1','');
INSERT INTO "files" VALUES(112802110,'ibm'':8.0','x64_mac','ibm_legacy_sdk_sha','darwin-x64-installmgr','sha256.txt',':iman','ibm-java-sdk-(.*?)-darwin-x64-installmgr.zip','2','');

INSERT INTO "files" VALUES(112802201,'ibm'':7.0','sparc_solaris','ibm_legacy_sdk','sol','tar.Z',':test:jim:oem','','','1');
INSERT INTO "files" VALUES(112802202,'ibm'':7.0','sparc_solaris','ibm_legacy_sdk','sol','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802203,'ibm'':7.0','sparc_solaris','ibm_legacy_sdk_sha','SolarisSPARC32','sha256.txt',':fhd','sol(.*?)-sdk.tar.Z','2','');
INSERT INTO "files" VALUES(112802204,'ibm'':7.0','sparc_solaris','ibm_legacy_jre','sol','tar.Z',':jim:oem','','','2');
INSERT INTO "files" VALUES(112802205,'ibm'':7.0','sparc_solaris','ibm_legacy_jre','sol','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802206,'ibm'':7.0','sparc_solaris','ibm_legacy_jre_sha','SolarisSPARC32','sha256.txt',':fhd','sol(.*?)-jre.tar.Z','2','');
INSERT INTO "files" VALUES(112802301,'ibm'':7.0:8.0','sparcv9_solaris','ibm_legacy_sdk','sol64(.*?)-sdk.tar.Z',':test:jim:oem','','','1');
INSERT INTO "files" VALUES(112802302,'ibm'':7.0:8.0','sparcv9_solaris','ibm_legacy_sdk','sol64(.*?)-sdk.tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802303,'ibm'':7.0:8.0','sparcv9_solaris','ibm_legacy_sdk_sha','SolarisSPARC64.sha256.txt',':fhd','sol64(.*?)-sdk.tar.Z','2','');
INSERT INTO "files" VALUES(112802304,'ibm'':7.0:8.0','sparcv9_solaris','ibm_legacy_jre','sol64','tar.Z',':jim:oem','','','2');
INSERT INTO "files" VALUES(112802305,'ibm'':7.0:8.0','sparcv9_solaris','ibm_legacy_jre','sol64','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802306,'ibm'':7.0:8.0','sparcv9_solaris','ibm_legacy_jre_sha','SolarisSPARC64','sha256.txt',':fhd','sol64(.*?)-jre.tar.Z','2','');
INSERT INTO "files" VALUES(112802307,'ibm'':8.0','sparcv9_solaris','ibm-java-sdk-(.*?)-sol-sparc64-installmgr.zip',':iman','','1','');
--INSERT INTO "files" VALUES(112802308,'ibm'':8.0','sparcv9_solaris','ibm-java-sdk-(.*?)-sol-sparc64-installmgr.zip.sig',':iman','','2','');
INSERT INTO "files" VALUES(112802309,'ibm'':8.0','sparcv9_solaris','ibm_legacy_sdk_sha','sol-sparc64-installmgr','sha256.txt',':iman','ibm-java-sdk-(.*?)-sol-sparc64-installmgr.zip','2','');

INSERT INTO "files" VALUES(112802401,'ibm'':7.0:8.0','x64_solaris','ibm_legacy_sdk','solx64','tar.Z',':test:jim:oem','','','1');
INSERT INTO "files" VALUES(112802402,'ibm'':7.0:8.0','x64_solaris','ibm_legacy_sdk','solx64','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802403,'ibm'':7.0:8.0','x64_solaris','ibm_legacy_sdk_sha','Solarisx8664','sha256.txt',':fhd','solx64(.*?)-sdk.tar.Z','2','');
INSERT INTO "files" VALUES(112802404,'ibm'':7.0:8.0','x64_solaris','ibm_legacy_jre','solx64','tar.Z',':jim:oem','','','2');
INSERT INTO "files" VALUES(112802405,'ibm'':7.0:8.0','x64_solaris','ibm_legacy_jre','solx64','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802406,'ibm'':7.0:8.0','x64_solaris','ibm_legacy_jre_sha','Solarisx8664','sha256.txt',':fhd','solx64(.*?)-jre.tar.Z','2','');
INSERT INTO "files" VALUES(112802407,'ibm'':8.0','x64_solaris','ibm-java-sdk-(.*?)-sol-x64-installmgr.zip',':iman','','1','');
--INSERT INTO "files" VALUES(112802408,'ibm'':8.0','x64_solaris','ibm-java-sdk-(.*?)-sol-x64-installmgr.zip.sig',':iman','','2','');
INSERT INTO "files" VALUES(112802409,'ibm'':8.0','x64_solaris','ibm_legacy_sdk_sha','sol-x64-installmgr','sha256.txt',':iman','ibm-java-sdk-(.*?)-sol-x64-installmgr.zip','2','');
INSERT INTO "files" VALUES(112802501,'ibm'':7.0','x32_solaris','ibm_legacy_sdk','solx86','tar.Z',':test:jim:oem','','','1');
INSERT INTO "files" VALUES(112802502,'ibm'':7.0','x32_solaris','ibm_legacy_sdk','solx86','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802503,'ibm'':7.0','x32_solaris','ibm_legacy_sdk_sha','Solarisx8632','sha256.txt',':fhd','solx86(.*?)-sdk.tar.Z','2','');
INSERT INTO "files" VALUES(112802504,'ibm'':7.0','x32_solaris','ibm_legacy_jre','solx86','tar.Z',':jim:oem','','','2');
INSERT INTO "files" VALUES(112802505,'ibm'':7.0','x32_solaris','ibm_legacy_jre','solx86','tar.Z',':fhd','','1','');
INSERT INTO "files" VALUES(112802506,'ibm'':7.0','x32_solaris','ibm_legacy_jre_sha','Solarisx8632','sha256.txt',':fhd','solx86(.*?)-jre.tar.Z','2','');