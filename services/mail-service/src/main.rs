use tokio::net::TcpListener;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "0.0.0.0:8084";

    println!(">>> Mail Service is starting...");
    println!(">>> Listening on port 8084");

    let listener = TcpListener::bind(addr).await?;

    loop {
        let (_socket, _addr) = listener.accept().await?;
        println!(">>> Connection received");
    }
}
