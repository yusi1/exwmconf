#!/bin/bash

### Tag all emails from "me" as "sent"
notmuch tag +sent -- from:YUZi54780@outlook.com

### Do some post-processing of emails here
# immediately archive all messages from "me"
notmuch tag -- from:YUZi54780@outlook.com or from:yaslam0x1@gmail.com

# archive all messages from "other"
notmuch tag -- from:ashz.one@hotmail.com

# tag all messages to me as "personal"
notmuch tag +personal -- to:YUZi54780@outlook.com

# tag all messages to other as "other"
notmuch tag +other -- to:ashz.one@hotmail.com

# tag all messages urgent from "*noip*"
notmuch tag +urgent +noip -- from:*noip* and subject:"Action Required"

# tag all messages urgent from "Important" emails
notmuch tag +urgent -- subject:"Important" or subject:"Action Required"

# tag all messages from RedHat mailing list
notmuch tag +redhat -- from:errata@redhat.com

# tag all messages from Debian mailing list
notmuch tag +debian +personal -- to:debian-security-announce@lists.debian.org

# tag all messages from Emacs-devel mailing list
notmuch tag +emacs-devel +personal -- to:emacs-devel@gnu.org

# tag all messages from bug-gnu-emacs mailing list
notmuch tag +emacs-bugs +personal -- to:debbugs.gnu.org
