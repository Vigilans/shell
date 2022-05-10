# History file
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
setopt histignorespace                                          # Don't save commands that start with space
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
# setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.

# Directories
DIRSTACKSIZE=10
setopt autocd                                                   # If only directory path is entered, cd there.
setopt autopushd                                                # Make cd push the old directory onto the directory stack.
setopt cdablevars                                               # If this is set, an argument to the cd builtin command that is not a directory is assumed to be the name of a variable whose value is the directory to change to.
setopt pushdignoredups                                          # Don’t push multiple copies of the same directory onto the directory stack.
setopt pushdminus                                               # Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack.
setopt pushdsilent                                              # Do not print the directory stack after pushd or popd.
setopt pushdtohome                                              # Have pushd with no arguments act like ‘pushd $HOME’.

# Globbing
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
# setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
# setopt nocaseglob                                               # Case insensitive globbing

# Miscellaneous
setopt rcexpandparam                                            # Array expansions of the form ‘foo${xx}bar’, where the parameter xx is set to (a b c), are substituted with ‘fooabar foobbar foocbar’ instead of the default ‘fooa b cbar’. Note that an empty array will therefore cause all arguments to be removed.
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt nobeep                                                   # No beep
# setopt correct                                                  # Auto correct mistakes

# Use bash word style
autoload -U select-word-style
select-word-style bash
