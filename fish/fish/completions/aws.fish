# It first checks if the aws_completer program is executable, then does the command @hawkeyej gave above. That way there's no errors if aws cli is not in stalled.
# See [here](https://github.com/aws/aws-cli/issues/1079#issuecomment-252947755)
test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
