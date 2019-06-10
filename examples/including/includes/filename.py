#included file "filename.py"

from SCons.Script import *	# Needed so we can use scons stuff like builders

def Init(env):
	#Make builder
	obj = Builder(action="gcc -c -o $TARGET $SOURCE")

	#Add stuff
	env.Append(BUILDERS= {'Obj': obj})
	env.Append(VERSION= "1.6.2")
