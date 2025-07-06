package br.com.sdvs.base.component;

import org.graalvm.polyglot.io.FileSystem;
import java.io.IOException;
import java.net.URI;
import java.nio.channels.SeekableByteChannel;
import java.nio.file.*;
import java.nio.file.DirectoryStream.Filter;
import java.nio.file.attribute.FileAttribute;
import java.util.Map;
import java.util.Set;

public class DatabaseFileSystem implements FileSystem {

    private final DatabaseModuleService dbService;
    private final Path mountPoint;
    private volatile Path currentWorkingDirectory;

    public DatabaseFileSystem(DatabaseModuleService dbService) {
        this.dbService = dbService;
        this.mountPoint = Paths.get("/").toAbsolutePath();
        this.currentWorkingDirectory = this.mountPoint;
        //System.out.println("[DB_FS] Inicializado. Ponto de montagem: " + this.mountPoint);
    }

    private String toVirtualPath(Path hostPath) {
        Path absoluteHostPath = hostPath.isAbsolute() ? hostPath : toAbsolutePath(hostPath);
        String virtualPath = "/" + mountPoint.relativize(absoluteHostPath).toString().replace('\\', '/');
        //System.out.println("[DB_FS] toVirtualPath: " + hostPath + " -> " + virtualPath);
        return virtualPath;
    }

    @Override
    public void setCurrentWorkingDirectory(Path path) {
        //System.out.println("[DB_FS] setCurrentWorkingDirectory: " + path);
        this.currentWorkingDirectory = path.isAbsolute() ? path : toAbsolutePath(path);
    }

    @Override
    public Path toAbsolutePath(Path path) {
        //System.out.println("[DB_FS] toAbsolutePath: " + path + " (CWD: " + this.currentWorkingDirectory + ")");
        if (path.isAbsolute()) {
            return path.normalize();
        }
        Path result = this.currentWorkingDirectory.resolve(path).normalize();
        //System.out.println("[DB_FS] toAbsolutePath result: " + result);
        return result;
    }

    @Override
    public Path parsePath(String path) {
        //System.out.println("[DB_FS] parsePath(String): " + path);
        return Paths.get(path);
    }

    @Override
    public Path parsePath(URI uri) {
        //System.out.println("[DB_FS] parsePath(URI): " + uri);
        return Paths.get(uri);
    }

    @Override
    public Path toRealPath(Path path, LinkOption... linkOptions) throws IOException {
        //System.out.println("[DB_FS] toRealPath: " + path);
        Path absoluteHostPath = toAbsolutePath(path);
        String virtualPath = toVirtualPath(absoluteHostPath);
        if (!dbService.moduleExists(virtualPath)) {
            //System.err.println("[DB_FS] ERRO em toRealPath: não encontrou " + virtualPath);
            throw new NoSuchFileException(path.toString());
        }
        //System.out.println("[DB_FS] toRealPath retornando: " + absoluteHostPath);
        return absoluteHostPath;
    }

    @Override
    public void checkAccess(Path path, Set<? extends AccessMode> modes, LinkOption... linkOptions) throws IOException {
        //System.out.println("[DB_FS] checkAccess: " + path);
        String virtualPath = toVirtualPath(path);
        if (!dbService.moduleExists(virtualPath)) {
            //System.err.println("[DB_FS] ERRO em checkAccess: não encontrou " + virtualPath);
            throw new NoSuchFileException("Virtual path not found: " + virtualPath);
        }
    }

    @Override
    public Map<String, Object> readAttributes(Path path, String attributes, LinkOption... options) throws IOException {
        //System.out.println("[DB_FS] readAttributes: " + path);
        String virtualPath = toVirtualPath(path);
        if (!dbService.moduleExists(virtualPath)) {
            //System.err.println("[DB_FS] ERRO em readAttributes: não encontrou " + virtualPath);
            throw new NoSuchFileException(virtualPath);
        }
        return Map.of(
            "isRegularFile", true, "isDirectory", false, "isSymbolicLink", false,
            "size", (long) dbService.findModuleContentByPath(virtualPath).get().length()
        );
    }

    @Override
    public SeekableByteChannel newByteChannel(Path path, Set<? extends OpenOption> options, FileAttribute<?>... attrs) throws IOException {
        //System.out.println("[DB_FS] newByteChannel: " + path);
        if (options.contains(StandardOpenOption.WRITE)) {
            throw new UnsupportedOperationException("Write not supported");
        }
        String virtualPath = toVirtualPath(path);
        //System.out.println("[DB_FS] newByteChannel virtual path: " + virtualPath);
        String content = dbService.findModuleContentByPath(virtualPath)
                .orElseThrow(() -> {
                    //System.err.println("[DB_FS] ERRO em newByteChannel: não encontrou " + virtualPath);
                    return new NoSuchFileException(virtualPath);
                });
        byte[] contentBytes = content.getBytes(java.nio.charset.StandardCharsets.UTF_8);
        return new ReadOnlySeekableByteChannel(contentBytes);
    }

    @Override
    public void createDirectory(Path dir, FileAttribute<?>... attrs) throws IOException {
        //System.out.println("[DB_FS] createDirectory (não suportado): " + dir);
        throw new IOException("Read-only");
    }

    @Override
    public void delete(Path path) throws IOException {
        //System.out.println("[DB_FS] delete (não suportado): " + path);
        throw new IOException("Read-only");
    }

    @Override
    public DirectoryStream<Path> newDirectoryStream(Path dir, Filter<? super Path> filter) throws IOException {
        throw new UnsupportedOperationException("Unimplemented method 'newDirectoryStream'");
    }
}