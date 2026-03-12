import grpc
from concurrent import futures
import time

class SimpleServer:
    def serve(self):
        # Create a gRPC server
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
        
        # Standard gRPC port
        port = "8083"
        server.add_insecure_port(f'[::]:{port}')
        
        print(f">>> Python gRPC Server is starting...")
        print(f">>> Listening on port {port}")
        
        server.start()
        
        # Keep the process alive
        try:
            while True:
                time.sleep(86400)
        except KeyboardInterrupt:
            server.stop(0)

if __name__ == "__main__":
    SimpleServer().serve()