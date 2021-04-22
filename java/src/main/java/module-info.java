module jxtp {
    requires org.scijava.nativelib;
    exports org.rationalityfrontline.jxtp;
    opens natives.windows_64;
    opens natives.linux_64;
    opens natives.osx_64;
}