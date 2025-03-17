pub use std::collections::BTreeMap;
//use BTreeMap
use dashmap::DashMap;
pub use easytier::common::global_ctx::{EventBusSubscriber, GlobalCtxEvent};
use easytier::common::scoped_task::ScopedTask;
pub use easytier::{
    common::config::{ConfigLoader, TomlConfigLoader},
    launcher::NetworkInstance,
    proto,
};
pub use easytier::{
    common::{
        self,
        config::{NetworkIdentity, PeerConfig},
    },
    proto::{
        cli::{
            list_peer_route_pair, ConnectorManageRpc, ConnectorManageRpcClientFactory,
            DumpRouteRequest, GetVpnPortalInfoRequest, ListConnectorRequest,
            ListForeignNetworkRequest, ListGlobalForeignNetworkRequest, ListPeerRequest,
            ListPeerResponse, ListRouteRequest, ListRouteResponse, NodeInfo, PeerInfo,
            PeerManageRpc, PeerManageRpcClientFactory, PeerRoutePair, Route, ShowNodeInfoRequest,
            TcpProxyEntryState, TcpProxyEntryTransportType, TcpProxyRpc, TcpProxyRpcClientFactory,
            VpnPortalRpc, VpnPortalRpcClientFactory,
        },
        common::NatType,
        peer_rpc::{GetGlobalPeerMapRequest, PeerCenterRpc, PeerCenterRpcClientFactory},
        rpc_impl::standalone::StandAloneClient,
        rpc_types::controller::BaseController,
        web::MyNodeInfo,
    },
    utils::cost_to_str,
};
use flutter_rust_bridge::frb;
use lazy_static::lazy_static;
use once_cell::sync::Lazy;
use serde_json::json;
use tokio::runtime::Runtime;
pub use tokio::task::JoinHandle;

// pub struct Ipv4Addr {
//     pub addr: u32,
// }
// pub struct Ipv4Inet {
//     pub address: Option<Ipv4Addr>,
//     pub network_length: u32,
// }

// pub struct StunInfo {
//     pub udp_nat_type: i32,
//     pub tcp_nat_type: i32,
//     pub last_update_time: i64,
//     pub public_ip: Vec<String>,
//     pub min_port: u32,
//     pub max_port: u32,
// }
// pub struct PeerFeatureFlag {
//     pub is_public_server: bool,
//     pub avoid_relay_data: bool,
//     pub kcp_input: bool,
//     pub no_relay_kcp: bool,
// }
// pub struct Route {
//     pub peer_id: u32,
//     pub ipv4_addr: Option<Ipv4Inet>,
//     pub next_hop_peer_id: u32,
//     pub cost: i32,
//     pub path_latency: i32,
//     pub proxy_cidrs: Vec<String>,
//     pub hostname: String,
//     pub stun_info: Option<StunInfo>,
//     pub inst_id: String,
//     pub version: String,
//     pub feature_flag: Option<PeerFeatureFlag>,
//     pub next_hop_peer_id_latency_first: Option<u32>,
//     pub cost_latency_first: Option<i32>,
//     pub path_latency_latency_first: Option<i32>,
// }
// pub struct Url {
//     pub url: String,
// }
// pub struct TunnelInfo {
//     pub tunnel_type: String,
//     pub local_addr: Option<Url>,
//     pub remote_addr: Option<Url>,
// }

// pub struct PeerConnStats {
//     pub rx_bytes: u64,
//     pub tx_bytes: u64,
//     pub rx_packets: u64,
//     pub tx_packets: u64,
//     pub latency_us: u64,
// }
// pub struct PeerConnInfo {
//     pub conn_id: String,
//     pub my_peer_id: u32,
//     pub peer_id: u32,
//     pub features: Vec<String>,
//     pub tunnel: Option<TunnelInfo>,
//     pub stats: Option<PeerConnStats>,
//     pub loss_rate: f32,
//     pub is_client: bool,
//     pub network_name: String,
// }
// pub struct PeerInfo {
//     pub peer_id: u32,
//     pub conns: Vec<PeerConnInfo>,
// }

// pub struct PeerRoutePair {
//     pub route: Option<Route>,
//     pub peer: Option<PeerInfo>,
// }
// pub struct Runin {
//     pub dev_name: String,
//     pub my_node_info: Option<MyNodeInfo>,
//     pub events: Vec<String>,
//     pub routes: Vec<Route>,
//     pub peers: Vec<PeerInfo>,
//     pub peer_route_pairs: Vec<PeerRoutePair>,
//     pub running: bool,
//     pub error_msg: Option<String>,
// }
// pub struct Ipv6Addr {
//     pub part1: u32,
//     pub part2: u32,
//     pub part3: u32,
//     pub part4: u32,
// }
// pub struct GetIpListResponse {
//     pub public_ipv4: Option<Ipv4Addr>,
//     pub interface_ipv4s: Vec<Ipv4Addr>,
//     pub public_ipv6: Option<Ipv6Addr>,
//     pub interface_ipv6s: Vec<Ipv6Addr>,
//     pub listeners: Vec<Url>,
// }
// pub struct MyNodeInfo {
//     pub virtual_ipv4: Option<Ipv4Inet>,
//     pub hostname: String,
//     pub version: String,
//     pub ips: Option<GetIpListResponse>,
//     pub stun_info: Option<StunInfo>,
//     pub listeners: Vec<Url>,
//     pub vpn_portal_cfg: Option<String>,
// }

static INSTANCE_MAP: Lazy<DashMap<String, NetworkInstance>> = Lazy::new(DashMap::new);
// 创建一个 NetworkInstance 类型变量 储存当前服务器
lazy_static! {
    static ref RT: Runtime = Runtime::new().expect("创建 Tokio 运行时失败");
}

fn create_config() -> TomlConfigLoader {
    let mut cfg = TomlConfigLoader::default();
    // 构造 PeerConfig 实例并设置 peers

    cfg.set_listeners(vec![
        "tcp://0.0.0.0:11010".to_string().parse().unwrap(),
        "udp://0.0.0.0:11010".to_string().parse().unwrap(),
    ]);
    // cfg.set_inst_name("default".to_string());
    // cfg.set_inst_name(name);
    cfg
}

// 添加一个函数来获取对等节点和路由信息
pub fn get_peers_and_routes() -> Result<(Vec<PeerInfo>, Vec<Route>), String> {
    if let Some(instance) = INSTANCE_MAP.iter().next() {
        // 获取运行信息
        if let Some(info) = instance.get_running_info() {
            return Ok((info.peers, info.routes));
        }
        return Err("无法获取运行信息".to_string());
    }
    Err("没有运行中的网络实例".to_string())
}

// 如果需要获取配对后的信息，可以使用这个函数
pub fn get_peer_route_pairs() -> Result<Vec<PeerRoutePair>, String> {
    if let Some(instance) = INSTANCE_MAP.iter().next() {
        // 获取运行信息
        if let Some(info) = instance.get_running_info() {
            let mut pairs = info.peer_route_pairs;

            // 如果存在本地节点信息，添加到结果中
            if let Some(my_node_info) = &info.my_node_info {
                // 获取本地节点ID
                let my_peer_id = info
                    .peers
                    .iter()
                    .find(|p| p.conns.iter().any(|c| c.is_client == false))
                    .map(|p| p.peer_id)
                    .unwrap_or(0);

                // 创建一个表示本地节点的Route
                let my_route = proto::cli::Route {
                    peer_id: my_peer_id,
                    ipv4_addr: my_node_info.virtual_ipv4.clone(),
                    next_hop_peer_id: my_peer_id, // 指向自己
                    cost: 0,                      // 到自己的成本为0
                    path_latency: 0,              // 到自己的延迟为0
                    proxy_cidrs: vec![],
                    hostname: my_node_info.hostname.clone(),
                    stun_info: my_node_info.stun_info.clone(),
                    inst_id: "local".to_string(),
                    version: my_node_info.version.clone(),
                    feature_flag: None,
                    next_hop_peer_id_latency_first: None,
                    cost_latency_first: None,
                    path_latency_latency_first: None,
                };

                // 创建一个表示本地节点的PeerInfo，包含网络统计信息
                let my_peer_info = info.peers.iter().find(|p| p.peer_id == my_peer_id).cloned();

                // 创建一个表示本地节点的PeerRoutePair
                let my_pair = proto::cli::PeerRoutePair {
                    route: Some(my_route),
                    peer: my_peer_info, // 使用找到的PeerInfo或None
                };

                // 添加到结果中
                pairs.push(my_pair);
            }

            return Ok(pairs);
        }
        return Err("无法获取运行信息".to_string());
    }
    Err("没有运行中的网络实例".to_string())
}

// 获取节点信息
pub fn get_node_info() -> Result<MyNodeInfo, String> {
    if let Some(instance) = INSTANCE_MAP.iter().next() {
        // 获取运行信息
        if let Some(info) = instance.get_running_info() {
            if let Some(node_info) = info.my_node_info {
                return Ok(node_info);
            }
            return Err("无法获取节点信息".to_string());
        }
        return Err("无法获取运行信息".to_string());
    }
    Err("没有运行中的网络实例".to_string())
}

async fn create_and_store_network_instance(cfg: TomlConfigLoader) -> Result<(), String> {
    println!("Starting easytier with config:");
    println!("############### TOML ###############\n");
    println!("{}", cfg.dump());
    println!("-----------------------------------");
    // 在移动 cfg 之前先获取 ID
    let name = cfg.get_id().to_string();
    // 创建网络实例
    let mut instance = NetworkInstance::new(cfg).set_fetch_node_info(true);
    // 启动网络实例，并处理可能的错误
    instance.start().unwrap();
    println!("instance {} started", name);
    // 将实例存储到 INSTANCE_MAP 中
    INSTANCE_MAP.insert(name, instance);

    Ok(())
}

// 返回EasyTier的版本号
pub fn easytier_version() -> Result<String, String> {
    Ok(easytier::VERSION.to_string())
}

// 是否在运行
pub fn is_easytier_running() -> bool {
    if let Some(instance) = INSTANCE_MAP.iter().next() {
        instance.is_easytier_running()
    } else {
        false
    }
}

// 定义节点连接统计信息结构体
pub struct KVNodeConnectionStats {
    pub conn_type: String, // 连接类型
    pub rx_bytes: u64,
    pub tx_bytes: u64,
    pub rx_packets: u64,
    pub tx_packets: u64,
}
// 定义节点信息结构体
pub struct KVNodeInfo {
    pub hostname: String,
    pub ipv4: String,
    pub latency_ms: f64,
    pub nat: String, // NAT类型
    pub loss_rate: f32,
    pub connections: Vec<KVNodeConnectionStats>,
    pub version: String,
    pub cost: i32,
}
// 定义节点网络状态结构体
pub struct KVNetworkStatus {
    pub total_nodes: usize,
    pub nodes: Vec<KVNodeInfo>,
}

// 获取网络状态信息
pub fn get_network_status() -> KVNetworkStatus {
    let pairs = get_peer_route_pairs().unwrap_or_default();
    let mut nodes = Vec::new();

    for pair in pairs.iter() {
        if let Some(route) = &pair.route {
            let cost = route.cost;
            // 使用 get_running_info 中的逻辑来获取IPv4地址
            let ipv4 = route
                .ipv4_addr
                .as_ref()
                .and_then(|addr| addr.address.as_ref())
                .map(|a| {
                    format!(
                        "{}.{}.{}.{}",
                        (a.addr >> 24) & 0xFF,
                        (a.addr >> 16) & 0xFF,
                        (a.addr >> 8) & 0xFF,
                        a.addr & 0xFF
                    )
                })
                .unwrap_or_else(|| "0.0.0.0".to_string());

            let mut node_info = KVNodeInfo {
                hostname: route.hostname.clone(),
                ipv4,
                latency_ms: if let Some(peer) = &pair.peer {
                    let mut min_latency = u64::MAX;
                    for conn in &peer.conns {
                        if let Some(stats) = &conn.stats {
                            min_latency = min_latency.min(stats.latency_us);
                        }
                    }
                    if min_latency == u64::MAX {
                        // 如果没有找到有效的连接延迟，则使用路由路径延迟
                        f64::from(route.path_latency.max(0)) / 1000.0
                    } else {
                        // 将微秒转换为毫秒
                        f64::from(min_latency as u32) / 1000.0
                    }
                } else {
                    // 如果没有peer信息，则使用路由路径延迟
                    f64::from(route.path_latency.max(0)) / 1000.0
                },
                loss_rate: if let Some(peer) = &pair.peer {
                    let mut total_loss_rate = 0.0;
                    for conn in &peer.conns {
                        total_loss_rate += conn.loss_rate;
                    }
                    total_loss_rate
                } else {
                    0.0 // 如果没有连接信息，默认为0
                },
                nat: route.stun_info.as_ref().map_or_else(
                    || "Unknown".to_string(),
                    |stun| {
                        // 使用NatType枚举替代直接匹配数字
                        let nat_type = NatType::try_from(stun.udp_nat_type).unwrap_or(NatType::Unknown);
                        format!("{:?}", nat_type)
                    }
                ),
                connections: Vec::new(),
                version: route.version.clone(),
                cost,
            };

            // 收集连接统计信息
            if let Some(peer) = &pair.peer {
                for conn in &peer.conns {
                    if let Some(stats) = &conn.stats {
                        let conn_type = if let Some(tunnel) = &conn.tunnel {
                            tunnel.tunnel_type.clone()
                        } else {
                            "未知".to_string()
                        };

                        node_info.connections.push(KVNodeConnectionStats {
                            conn_type,
                            rx_bytes: stats.rx_bytes,
                            tx_bytes: stats.tx_bytes,
                            rx_packets: stats.rx_packets,
                            tx_packets: stats.tx_packets,
                        });
                    }
                }
            }

            nodes.push(node_info);
        }
    }

    KVNetworkStatus {
        total_nodes: nodes.len(),
        nodes,
    }
}

pub fn get_running_info() -> String {
    INSTANCE_MAP
        .iter()
        .next()
        .and_then(|instance| instance.get_running_info())
        .and_then(|info| {
            // 获取并打印节点路由对信息
            serde_json::to_string(&json!({
                "dev_name": info.dev_name,
                "my_node_info": info.my_node_info.as_ref().map(|node| json!({
                    "virtual_ipv4": node.virtual_ipv4.as_ref().map(|addr| json!({
                        "address": addr.address.as_ref().map(|a| json!({ "addr": a.addr })),
                        "network_length": addr.network_length
                    })),
                    "hostname": node.hostname,
                    "version": node.version,
                    "ips": node.ips.as_ref().map(|ips| json!({
                        "public_ipv4": ips.public_ipv4.as_ref().map(|a| json!({ "addr": a.addr })),
                        "interface_ipv4s": ips.interface_ipv4s.iter().map(|a| json!({ "addr": a.addr })).collect::<Vec<_>>(),
                        "public_ipv6": ips.public_ipv6.as_ref().map(|a| json!({
                            "part1": a.part1,
                            "part2": a.part2,
                            "part3": a.part3,
                            "part4": a.part4
                        })),
                        "interface_ipv6s": ips.interface_ipv6s.iter().map(|a| json!({
                            "part1": a.part1,
                            "part2": a.part2,
                            "part3": a.part3,
                            "part4": a.part4
                        })).collect::<Vec<_>>(),
                        "listeners": ips.listeners.iter().map(|l| json!({ "url": l.to_string() })).collect::<Vec<_>>()
                    })),
                    "stun_info": node.stun_info.as_ref().map(|info| json!({
                        "udp_nat_type": info.udp_nat_type,
                        "tcp_nat_type": info.tcp_nat_type,
                        "last_update_time": info.last_update_time,
                        "public_ip": info.public_ip,
                        "min_port": info.min_port,
                        "max_port": info.max_port
                    })),
                    "listeners": node.listeners.iter().map(|l| json!({ "url": l.url })).collect::<Vec<_>>(),
                    "vpn_portal_cfg": node.vpn_portal_cfg
                })),
                "events": info.events,
                "routes": info.routes.iter().map(|route| json!({
                    "peer_id": route.peer_id,
                    "ipv4_addr": route.ipv4_addr.as_ref().map(|addr| json!({
                        "address": addr.address.as_ref().map(|a| json!({ "addr": a.addr })),
                        "network_length": addr.network_length
                    })),
                    "next_hop_peer_id": route.next_hop_peer_id,
                    "cost": route.cost,
                    "path_latency": route.path_latency,
                    "proxy_cidrs": route.proxy_cidrs,
                    "hostname": route.hostname,
                    "stun_info": route.stun_info.as_ref().map(|info| json!({
                        "udp_nat_type": info.udp_nat_type,
                        "tcp_nat_type": info.tcp_nat_type,
                        "last_update_time": info.last_update_time,
                        "public_ip": info.public_ip,
                        "min_port": info.min_port,
                        "max_port": info.max_port
                    })),
                    "inst_id": route.inst_id,
                    "version": route.version,
                    "feature_flag": route.feature_flag.as_ref().map(|flag| json!({
                        "is_public_server": flag.is_public_server,
                        "avoid_relay_data": flag.avoid_relay_data,
                        "kcp_input": flag.kcp_input,
                        "no_relay_kcp": flag.no_relay_kcp
                    })),
                    "next_hop_peer_id_latency_first": route.next_hop_peer_id_latency_first,
                    "cost_latency_first": route.cost_latency_first,
                    "path_latency_latency_first": route.path_latency_latency_first
                })).collect::<Vec<_>>(),
                "peers": info.peers.iter().map(|peer| json!({
                    "peer_id": peer.peer_id,
                    "conns": peer.conns.iter().map(|conn| json!({
                        "conn_id": conn.conn_id,
                        "my_peer_id": conn.my_peer_id,
                        "peer_id": conn.peer_id,
                        "features": conn.features,
                        "tunnel": conn.tunnel.as_ref().map(|t| json!({
                            "tunnel_type": t.tunnel_type,
                            "local_addr": t.local_addr.as_ref().map(|a| json!({ "url": a.url })),
                            "remote_addr": t.remote_addr.as_ref().map(|a| json!({ "url": a.url }))
                        })),
                        "stats": conn.stats.as_ref().map(|s| json!({
                            "rx_bytes": s.rx_bytes,
                            "tx_bytes": s.tx_bytes,
                            "rx_packets": s.rx_packets,
                            "tx_packets": s.tx_packets,
                            "latency_us": s.latency_us
                        })),
                        "loss_rate": conn.loss_rate,
                        "is_client": conn.is_client,
                        "network_name": conn.network_name
                    })).collect::<Vec<_>>()
                })).collect::<Vec<_>>(),
                "peer_route_pairs": info.peer_route_pairs.iter().map(|pair| json!({
                    "route": pair.route.as_ref().map(|route| json!({
                        "peer_id": route.peer_id,
                        "ipv4_addr": route.ipv4_addr.as_ref().map(|addr| json!({
                            "address": addr.address.as_ref().map(|a| json!({ "addr": a.addr })),
                            "network_length": addr.network_length
                        })),
                        "next_hop_peer_id": route.next_hop_peer_id,
                        "cost": route.cost,
                        "path_latency": route.path_latency,
                        "proxy_cidrs": route.proxy_cidrs,
                        "hostname": route.hostname,
                        "stun_info": route.stun_info.as_ref().map(|info| json!({
                            "udp_nat_type": info.udp_nat_type,
                            "tcp_nat_type": info.tcp_nat_type,
                            "last_update_time": info.last_update_time,
                            "public_ip": info.public_ip,
                            "min_port": info.min_port,
                            "max_port": info.max_port
                        })),
                        "inst_id": route.inst_id,
                        "version": route.version,
                        "feature_flag": route.feature_flag.as_ref().map(|flag| json!({
                            "is_public_server": flag.is_public_server,
                            "avoid_relay_data": flag.avoid_relay_data,
                            "kcp_input": flag.kcp_input,
                            "no_relay_kcp": flag.no_relay_kcp
                        })),
                        "next_hop_peer_id_latency_first": route.next_hop_peer_id_latency_first,
                        "cost_latency_first": route.cost_latency_first,
                        "path_latency_latency_first": route.path_latency_latency_first
                    })),
                    "peer": pair.peer.as_ref().map(|peer| json!({
                        "peer_id": peer.peer_id,
                        "conns": peer.conns.iter().map(|conn| json!({
                            "conn_id": conn.conn_id,
                            "my_peer_id": conn.my_peer_id,
                            "peer_id": conn.peer_id,
                            "features": conn.features,
                            "tunnel": conn.tunnel.as_ref().map(|t| json!({
                                "tunnel_type": t.tunnel_type,
                                "local_addr": t.local_addr.as_ref().map(|a| json!({ "url": a.url })),
                                "remote_addr": t.remote_addr.as_ref().map(|a| json!({ "url": a.url }))
                            })),
                            "stats": conn.stats.as_ref().map(|s| json!({
                                "rx_bytes": s.rx_bytes,
                                "tx_bytes": s.tx_bytes,
                                "rx_packets": s.rx_packets,
                                "tx_packets": s.tx_packets,
                                "latency_us": s.latency_us
                            })),
                            "loss_rate": conn.loss_rate,
                            "is_client": conn.is_client,
                            "network_name": conn.network_name
                        })).collect::<Vec<_>>()
                    }))
                })).collect::<Vec<_>>(),

                "running": info.running,
                "error_msg": info.error_msg
            })).ok()
        })
        .unwrap_or_else(|| "{}".to_string())
}

// 创建服务器
pub fn create_server(
    username: String,
    enable_dhcp: bool,
    specified_ip: String,
    room_name: String,
    room_password: String,
    severurl: Vec<String>,
) {
    RT.spawn(async move {
        // 创建一个示例配置
        let cfg = create_config();
        cfg.set_hostname(Option::from(username));
        cfg.set_dhcp(enable_dhcp);
        let mut flags = cfg.get_flags();
        // flags.dev_name = "astral".to_string();
        cfg.set_flags(flags);
        // 创建TCP和UDP连接配置列表
        let mut peer_configs = Vec::new();
        // 为每个服务器URL创建TCP和UDP配置
        for url in severurl {
            peer_configs.push(PeerConfig {
                uri: format!("tcp://{}", url).parse().unwrap(),
            });
            peer_configs.push(PeerConfig {
                uri: format!("udp://{}", url).parse().unwrap(),
            });
        }
        
        cfg.set_peers(peer_configs);
        if enable_dhcp == false {
            // 使用完整路径引用 cidr 模块的 Ipv4Inet
            // 解析IP地址和子网掩码
            let ip = format!("{}/24", specified_ip).parse().unwrap();
            cfg.set_ipv4(Some(ip));
        }
        cfg.set_network_identity(NetworkIdentity::new(
            room_name.to_string(),
            room_password.to_string(),
        ));

        // 并行启动网络实例
        let handle1 = tokio::spawn(async move {
            if let Err(e) = create_and_store_network_instance(cfg).await {
                eprintln!("创建网络实例失败: {}", e);
            }
        });

        // 等待所有任务完成
        let _ = tokio::join!(handle1);
    });
}

// 获取INSTANCE_MAP所有的服务器然后关闭
pub fn close_all_server() {
    RT.spawn(async {
        println!("关闭前实例数: {}", INSTANCE_MAP.len()); // 添加关闭前日志
        let keys: Vec<_> = INSTANCE_MAP.iter().map(|e| e.key().clone()).collect();
        println!("待关闭实例键: {:?}", keys); // 增加键列表输出

        for key in keys {
            if let Some((_, mut instance)) = INSTANCE_MAP.remove(&key) {
                //丢弃 instance
                drop(instance);
            } else {
                println!("未找到实例: {}", key); // 增加错误处理
            }
        }
        println!("关闭后剩余实例数: {}", INSTANCE_MAP.len()); // 添加关闭后日志
    });
}

pub fn init_app() {
    lazy_static::initialize(&RT);
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
