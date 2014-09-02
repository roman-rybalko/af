#!/bin/sh -ex

cadir="$1"
[ -n "$cadir" ] || cadir="ca"
rm -Rvf $cadir
mkdir $cadir

mkfiles()
{
    delim="$1"
    prefix="$2"
    src="$3"
    cnt=`grep "$delim" "$src" | wc -l`
    cnt=$(($cnt-1))
    if [ $cnt -gt 0 ]; then
        csplit -f "$prefix" -n 3 "$src" "/$delim/+1" "{$cnt}"
    else
        cp -vf "$src" "$prefix"000
    fi
}

for cacrt in ca-* ca.*; do
    [ -f "$cacrt" ] || continue
    mkfiles "END CERTIFICATE" "$cadir/ca-$cacrt-" "$cacrt"
done
for cacrl in crl-* crl.*; do
    [ -f "$cacrl" ] || continue
    mkfiles "END X509 CRL" "$cadir/crl-$cacrl-" "$cacrl"
done

mkhash()
{
    type=$1 # x509/crl
    suff=$2
    f="$3"
    hash=`openssl $type -hash -noout -in "$f" || true`
    if [ -n "$hash" ]; then
        i=0
        while [ -e $hash.$suff$i ]; do i=$(($i+1)); done
        openssl $type -in "$f" -text > $hash.$suff$i
    fi
    rm -vf "$f"
}

cd "$cadir"
for f in ca-*; do
    [ -f "$f" ] || continue
    mkhash x509 "" "$f"
done
for f in crl-*; do
    [ -f "$f" ] || continue
    mkhash crl r "$f"
done
