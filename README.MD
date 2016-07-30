# Phalcon Ubuntu PPA Package

The repository contains several branches:

| Branch  | Ubuntu Release | Phalcon Release | PHP version |
| ------------- | ------------- | ------------- | ------------- |
| [precise](https://github.com/phalcon/phalcon-ppa/tree/precise)  | Precise Pangolin 12.04 LTS  | Up to `2.0.9` | `5.3.x` |
| [trusty](https://github.com/phalcon/phalcon-ppa/tree/precise)  | Trusty Tahr 14.04 LTS  | Up to `3.0.0` | `5.5.x` |
| [vivid](https://github.com/phalcon/phalcon-ppa/tree/vivid)  | Vivid Vervet 15.04  | Up to `3.0.0` | `5.6.x` |
| [wily](https://github.com/phalcon/phalcon-ppa/tree/wily)  | Wily Werewolf 15.10 | Up to `3.0.0` | `5.6.x` |
| [xenial](https://github.com/phalcon/phalcon-ppa/tree/xenial)  | Xenial Xerus 16.04 LTS | Up to `3.0.0` | `7.0.0` |

## Step 1: Generate gpg key and upload it

**Note:** This step is only required if you do not have a published gpg key that you can use to sign the packages.

1. Install needed dependencies:
   ```
   sudo apt-get install gnupg2 gnupg devscripts
   ```
2. Generate a new key:
   ```
   gpg2 --gen-key
   ```
3. Select the default (RSA and RSA)
4. Select a keysize (minimum 2048)
5. Select a expiration date (leave it 0 by default)
6. Enter your real name, email address and enter your github username as the comment
   Example: `Foo Bar (FooBar) <foo@bar.net>`
7. When the key is generated you will see a line similar to this:
   ```
   pub   4096R/<8-CHAR KEY ID> 2016-03-15
   ```
8. Upload your key: `gpg2 --send-keys <8-CHAR KEY ID>` The synchronization of the keyserver can take up to 15 minutes, so grab a tea/coffee and watch some `xkcd`
9. Search for your nickname on http://keyserver.ubuntu.com:11371/, when you see your key pop up then the synchronisation was completed. Select your fingerprint (it will show up in the search result). If you forgot to enter your nickname, simply run `gpg --fingerprint` and copy the fingerprint from there
10. Go to https://launchpad.net/~YOUR_NICK_NAME/+editpgpkeys, paste your fingerprint here. Launchpad will send you a ENCRYPTED email with a confirmation link
11. Open the email, if you don't see a link that has 'token' in it but you do see `-----BEGIN PGP MESSAGE-----` then you will need to decrypt this message. You can do this by putting the contents from BEGIN to END into a text file and run `gpg -d <file>`. Now the confirmation link should appear

## Step 2: Building the package

1.  Create a directory where you want to create the packages (e.g. `/home/foobar/phalcon`)
2.  Clone the phalcon-ppa repository (`git clone https://github.com/phalcon/phalcon-ppa.git php-phalcon`). The directory **MUST** be named `php-phalcon`
3.  If you need to bump the version (new version of Phalcon has been released) then you have to edit the changelog first (`vi debian/changelog`)
    * You will see a line similar to: `php-phalcon (3.0.0-ppa1~trusty) trusty; urgency=low`
    * Copy this line and change the version to the version of the new phalcon release and the operating system codename (`trusty`, `precise`, etc.) to the proper name. Make sure that you enter the name of the edition of Ubuntu that corresponds with the branch
    * Finish the changelog by adding the actual changes that you can find in the official Phalcon `CHANGELOG.md`
4.  Update the submodule of cphalcon by running: `git submodule update --init --recursive`
5.  Commit the changes to this branch and repeat the process for all branches (you can use `git merge <current branch>` and then enter the correct os name by resolving the merge conflict).
6.  Build the tar file for this release (`cd .. && tar -zc --exclude=.git --exclude=.gitmodules --exclude=debian --exclude=.gitignore -f php-phalcon_3.0.0.orig.tar.gz php-phalcon && cd php-phalcon`). Change the version to the correct version. The resulting tar must be one directory up from `php-phalcon`
7.  Go back to the `php-phalcon` directory (`cd php-phalcon`). Enter `gpg --list-keys` and copy your public key part (`pub 2048R/<something>`).
8.  Build the package by running: `debuild -S -sa -k<your pubkey>`
9.  Now upload the change file to the ppa. Go one directory up (`cd ..`) and upload the changes file (`dput ppa:phalcon/stable php-phalcon_3.0.0-ppa1~trusty_source.changes`)

Now an email should appear saying whether or not the package has been accepted.
