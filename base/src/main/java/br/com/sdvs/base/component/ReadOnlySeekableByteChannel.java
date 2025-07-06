package br.com.sdvs.base.component;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.NonWritableChannelException;
import java.nio.channels.SeekableByteChannel;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * Uma implementação de SeekableByteChannel somente leitura que opera sobre
 * um array de bytes na memória.
 */
public final class ReadOnlySeekableByteChannel implements SeekableByteChannel {

    private final byte[] data;
    private int position = 0;
    private final AtomicBoolean open = new AtomicBoolean(true);

    /**
     * O construtor agora aceita diretamente o array de bytes.
     * @param data O conteúdo do "arquivo".
     */
    public ReadOnlySeekableByteChannel(byte[] data) {
        this.data = data == null ? new byte[0] : data;
    }

    @Override
    public int read(ByteBuffer dst) throws IOException {
        ensureOpen();
        if (position >= data.length) {
            return -1; // Fim do canal (End-of-file)
        }
        int bytesToRead = Math.min(dst.remaining(), data.length - position);
        dst.put(data, position, bytesToRead);
        position += bytesToRead;
        return bytesToRead;
    }

    @Override
    public long position() throws IOException {
        ensureOpen();
        return position;
    }

    @Override
    public SeekableByteChannel position(long newPosition) throws IOException {
        ensureOpen();
        if (newPosition < 0 || newPosition > Integer.MAX_VALUE) {
            throw new IllegalArgumentException("Posição inválida: " + newPosition);
        }
        this.position = (int) newPosition;
        return this;
    }

    @Override
    public long size() throws IOException {
        ensureOpen();
        return data.length;
    }

    @Override
    public boolean isOpen() {
        return open.get();
    }

    @Override
    public void close() throws IOException {
        open.set(false);
    }

    private void ensureOpen() throws IOException {
        if (!open.get()) {
            throw new IOException("Canal fechado");
        }
    }

    // --- Métodos de escrita não são suportados ---

    @Override
    public int write(ByteBuffer src) throws IOException {
        throw new NonWritableChannelException();
    }

    @Override
    public SeekableByteChannel truncate(long size) throws IOException {
        throw new NonWritableChannelException();
    }
}