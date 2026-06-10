import struct
import zlib
import os

FLAG = "blackperl{h1dd3n_4ft3r_13nd_ch4nk}"

def create_png_chunk(chunk_type, data):
    chunk = chunk_type + data
    return struct.pack('>I', len(data)) + chunk + struct.pack('>I', zlib.crc32(chunk) & 0xffffffff)

def create_minimal_png(width=64, height=64):
    signature = b'\x89PNG\r\n\x1a\n'
    ihdr_data = struct.pack('>IIBBBBB', width, height, 8, 2, 0, 0, 0)
    ihdr = create_png_chunk(b'IHDR', ihdr_data)

    raw_data = b''
    for y in range(height):
        raw_data += b'\x00'
        for x in range(width):
            r = (x * 4 + y * 2) % 256
            g = (x * 2 + y * 4) % 256
            b = (x * 3 + y * 3) % 256
            raw_data += bytes([r, g, b])

    compressed = zlib.compress(raw_data)
    idat = create_png_chunk(b'IDAT', compressed)
    iend = create_png_chunk(b'IEND', b'')

    return signature + ihdr + idat + iend

def generate_challenge():
    png_data = create_minimal_png(64, 64)
    
    hidden_text = f"\n\n=== HIDDEN DATA ===\nFlag: {FLAG}\n===================\n"
    
    final_file = png_data + hidden_text.encode()

    output_dir = os.path.dirname(os.path.abspath(__file__))
    output_path = os.path.join(output_dir, 'dark_pearl.png')

    with open(output_path, 'wb') as f:
        f.write(final_file)

    print(f"Challenge file generated: {output_path}")
    print(f"File size: {len(final_file)} bytes")
    print(f"Flag: {FLAG}")

if __name__ == '__main__':
    generate_challenge()
