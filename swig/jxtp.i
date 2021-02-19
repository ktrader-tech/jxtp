%module(directors="1") jxtp

%include "stdint.i"
%include "arrays_java.i"
%include "string_array.i"
%include "long_array.i"
%apply (char **STRING_ARRAY, int LENGTH) { (char *ticker[], int count) };
%apply (long [], int LENGTH) { (int64_t bid1_qty[], int32_t bid1_count) }
%apply (long [], int LENGTH) { (int64_t ask1_qty[], int32_t ask1_count) }

%{
#include "xtp_trader_api.h"
#include "xtp_quote_api.h"
%}

%pragma(java) jniclassimports=%{
import org.scijava.nativelib.NativeLoader;
%}
%pragma(java) jniclasscode=%{
    private static boolean libraryLoaded = false;

    /**
     * 检查动态链接库是否已被正确加载
     * @return true if loaded else false
     */
    public final static boolean libraryLoaded() {
        return libraryLoaded;
    }

    static {
        try {
            NativeLoader.loadLibrary("xtpquoteapi");
            NativeLoader.loadLibrary("xtptraderapi");
            NativeLoader.loadLibrary("jxtp");
            swig_module_init();
            libraryLoaded = true;
        } catch (Exception e) {
            System.err.println("Failed to load XTP native library: \n" + e);
        }
    }

    /**
     * 删除 C++ 中对 jxtpJNI class 的全局引用，避免 GC root 的持续存在
     */
    public final static native void release();
%}

%wrapper %{
SWIGEXPORT void JNICALL Java_org_rationalityfrontline_jxtp_jxtpJNI_release(JNIEnv *jenv, jclass jcls) {
    jenv->DeleteGlobalRef(Swig::jclass_jxtpJNI);
    Swig::jclass_jxtpJNI = NULL;
}
%}

%ignore XTPQueryAssetRsp::unknown;
%ignore XTPQueryStkPositionRsp::unknown;
%ignore XTPQueryOptionAuctionInfoRsp::unknown;

%include "../cpp/src/xtp_api_data_type.h"
%include "../cpp/src/xtp_api_struct_common.h"
%include "../cpp/src/xoms_api_struct.h"
%include "../cpp/src/xoms_api_fund_struct.h"
%include "../cpp/src/xquote_api_struct.h"
%feature("director") XTP::API::QuoteSpi;
%include "../cpp/src/xtp_quote_api.h"
%include "../cpp/src/xtp_api_struct.h"
%feature("director") XTP::API::TraderSpi;
%include "../cpp/src/xtp_trader_api.h"
