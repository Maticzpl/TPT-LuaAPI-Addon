---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

-- The File System API contains functions for creating, deleting, modifying and enumerating files and folders. 
fileSystem = {}

--```
--table fs.list(string folder)
--```
--Returns a table containing a list of files and folders in "folder"<br>
---@param folder string
---@return string[]  
function fileSystem.list(folder)
end

--```
--boolean fs.exists(string path)
--```
--Returns a boolean indicating whether "path" exists as either a file or folder<br>
---@param path string  
---@return boolean
function fileSystem.exists(path)
end

--```
--boolean fs.isFile(string path)
--```
--Returns a boolean indicating whether "path" exists as a file (i.e not a folder)<br>
---@param path string  
---@return boolean
function fileSystem.isFile(path)
end

--```
--boolean fs.isDirectory(string path)
--```
--Returns a boolean indicating whether "path" exists as a folder (i.e not a file)<br>
---@param path string  
---@return boolean
function fileSystem.isDirectory(path)
end

--```
--boolean fs.isLink(string path)
--```
--Returns a boolean indicating whether "path" is a symbolic link<br>
---@param path string  
---@return boolean
function fileSystem.isLink(path)
end


--```
--boolean fs.makeDirectory(string path)
--```
--Creates the folder "path", this function is not recursive and won't create parent directories (makeDirectory("parent/child") will fail if "parent" does not exist). This function returns true on success and false on failure.<br>
---@param path string  
---@return boolean
function fileSystem.makeDirectory(path)
end

--```
--boolean fs.removeDirectory(string path)
--```
--Removes the empty folder specified by "path". This function returns true on success and false on failure.<br>
---@param path string  
---@return boolean
function fileSystem.removeDirectory(path)
end

--```
--boolean fs.removeFile(string path)
--```
--Removes the file "path". This function returns true on success and false on failure.<br>
---@param path string  
---@return boolean
function fileSystem.removeFile(path)
end

--```
--boolean fs.move(string path, string newPath)
--```
--Moves the file or folder specified by "path" to "newPath". This function returns true on success and false on failure.<br>
---@param path string  
---@param newPath string  
---@return boolean
function fileSystem.move(path, newPath)
end

--```
--boolean fs.copy(string path, string newPath)
--```
--Copies the file "path" to "newPath". This function returns true on success and false on failure.<br>
---@param path string  
---@param newPath string  
---@return boolean
function fileSystem.copy(path, newPath)
end

fs = fileSystem
