def FlagsForFile(filename, **kwargs):
  flags = [
    '-Wall',
    '-Wextra',
    '-Werror'
    '-pedantic',
    '-I', '.',
    '-isystem', '/usr/include',
    '-isystem', '/usr/local/include',
  ]

  data = kwargs['client_data']
  filetype = data['&filetype']

  if filetype == 'c':
    flags += ['-xc']
  elif filetype == 'cpp':
    flags += ['-xc++']
    flags += ['-std=c++11']
  else:
    flags = []

  return {
    'flags': flags,
    'do_cache': True
  }
