#! /bin/sh -e

wd=`dirname $0`

if [ -z "$@" ]; then
	echo "USAGE: $0 <mime>"
	exit 1
fi

sed -r 's/[[:space:]]+$//;s/$/\r/;' $1 > $1.new

$wd/dkim_signer $1.new dkim.advancedfiltering.net test $wd/dkim-test.key \
From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:\
Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:\
Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:\
In-Reply-To:References:\
List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:\
X-AdvancedFiltering-MessageData-SenderMailAddress:\
X-AdvancedFiltering-MessageData-SenderHostAddress:\
X-AdvancedFiltering-MessageData-SenderHostName:\
X-AdvancedFiltering-MessageData-SenderCertificateSubject:\
X-AdvancedFiltering-MessageData-SenderCertificateVerified:\
X-AdvancedFiltering-MessageData-SPFStatus:\
X-AdvancedFiltering-MessageData-SPFDescription:\
X-AdvancedFiltering-MessageData-SpamStatus:\
X-AdvancedFiltering-MessageData-SpamDescription\
 > $1.new2
cat $1.new >> $1.new2
mv -f $1.new2 $1
rm -f $1.new
