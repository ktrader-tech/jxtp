/* See:
 * https://stackoverflow.com/questions/42393651/passing-arrays-from-c-to-java-using-swig-directors-the-up-call
 * http://www.swig.org/Doc4.0/Java.html#Java_directors_typemaps
 */

%typemap(jstype) (long [], int LENGTH) "long[]"
%typemap(jtype) (long [], int LENGTH) "long[]"
%typemap(jni) (long [], int LENGTH) "jlongArray"
%typemap(javadirectorin) (long [], int LENGTH) "$jniinput"
%typemap(javain) (long [], int LENGTH) "$javainput"
%typemap(in,numinputs=1) (long [], int LENGTH) {
    $1 = JCALL2(GetLongArrayElements, jenv, $input, NULL);
    $2 = JCALL1(GetArrayLength, jenv, $input);
}
%typemap(freearg) (long [], int LENGTH) {
    JCALL3(ReleaseLongArrayElements, jenv, $input, $1, 0);
}
%typemap(directorin,descriptor="[L") (long [], int LENGTH) {
    $input = JCALL1(NewLongArray, jenv, $2);
    JCALL4(SetLongArrayRegion, jenv, $input, 0, $2, $1);
}
%typemap(directorargout) (long [], int LENGTH) {
    (jenv)->GetLongArrayRegion($input, 0, $2, $1);
}