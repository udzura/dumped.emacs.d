This file is NOT part of GNU Emacs.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

See <http://www.gnu.org/licenses/> for a copy of the GNU General
Public License.

Documentation:

This minor mode provides some enhancements to ruby-mode in
the contexts of RSpec specifications.  Namely, it provides the
following capabilities:

 * toggle back and forth between a spec and it's target (bound to
   `\C-c ,t`)

 * verify the spec file associated with the current buffer (bound to `\C-c ,v`)

 * verify the spec defined in the current buffer if it is a spec
   file (bound to `\C-c ,v`)

 * verify the example defined at the point of the current buffer (bound to `\C-c ,s`)

 * re-run the last verification process (bound to `\C-c ,r`)

 * toggle the pendingness of the example at the point (bound to
   `\C-c ,d`)

 * disable the example at the point by making it pending

 * reenable the disabled example at the point

 * run spec for entire project (bound to `\C-c ,a`)

You can choose whether to run specs using 'rake spec' or the 'spec'
command. Use the customization interface (customize-group
rspec-mode) or override using (setq rspec-use-rake-flag TVAL).

Options will be loaded from spec.opts or .rspec if it exists and
rspec-use-opts-file-when-available is not set to nil, otherwise it
will fallback to defaults.

Dependencies
------------

If `ansi-color` is available it will be loaded so that rspec output is
colorized properly. If `rspec-use-rvm` is set to true `rvm.el` is required.

The expectations depend on `el-expectations.el`.
