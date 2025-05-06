// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNetConfigCollection on Isar {
  IsarCollection<NetConfig> get netConfigs => this.collection();
}

const NetConfigSchema = CollectionSchema(
  name: r'NetConfig',
  id: 4121067347839155516,
  properties: {
    r'bind_device': PropertySchema(
      id: 0,
      name: r'bind_device',
      type: IsarType.bool,
    ),
    r'data_compress_algo': PropertySchema(
      id: 1,
      name: r'data_compress_algo',
      type: IsarType.long,
    ),
    r'default_protocol': PropertySchema(
      id: 2,
      name: r'default_protocol',
      type: IsarType.string,
    ),
    r'dev_name': PropertySchema(
      id: 3,
      name: r'dev_name',
      type: IsarType.string,
    ),
    r'dhcp': PropertySchema(
      id: 4,
      name: r'dhcp',
      type: IsarType.bool,
    ),
    r'disable_kcp_input': PropertySchema(
      id: 5,
      name: r'disable_kcp_input',
      type: IsarType.bool,
    ),
    r'disable_p2p': PropertySchema(
      id: 6,
      name: r'disable_p2p',
      type: IsarType.bool,
    ),
    r'disable_relay_kcp': PropertySchema(
      id: 7,
      name: r'disable_relay_kcp',
      type: IsarType.bool,
    ),
    r'disable_udp_hole_punching': PropertySchema(
      id: 8,
      name: r'disable_udp_hole_punching',
      type: IsarType.bool,
    ),
    r'enable_encryption': PropertySchema(
      id: 9,
      name: r'enable_encryption',
      type: IsarType.bool,
    ),
    r'enable_exit_node': PropertySchema(
      id: 10,
      name: r'enable_exit_node',
      type: IsarType.bool,
    ),
    r'enable_ipv6': PropertySchema(
      id: 11,
      name: r'enable_ipv6',
      type: IsarType.bool,
    ),
    r'enable_kcp_proxy': PropertySchema(
      id: 12,
      name: r'enable_kcp_proxy',
      type: IsarType.bool,
    ),
    r'hostname': PropertySchema(
      id: 13,
      name: r'hostname',
      type: IsarType.string,
    ),
    r'instance_name': PropertySchema(
      id: 14,
      name: r'instance_name',
      type: IsarType.string,
    ),
    r'ipv4': PropertySchema(
      id: 15,
      name: r'ipv4',
      type: IsarType.string,
    ),
    r'latency_first': PropertySchema(
      id: 16,
      name: r'latency_first',
      type: IsarType.bool,
    ),
    r'listeners': PropertySchema(
      id: 17,
      name: r'listeners',
      type: IsarType.stringList,
    ),
    r'mtu': PropertySchema(
      id: 18,
      name: r'mtu',
      type: IsarType.long,
    ),
    r'multi_thread': PropertySchema(
      id: 19,
      name: r'multi_thread',
      type: IsarType.bool,
    ),
    r'netns': PropertySchema(
      id: 20,
      name: r'netns',
      type: IsarType.string,
    ),
    r'network_name': PropertySchema(
      id: 21,
      name: r'network_name',
      type: IsarType.string,
    ),
    r'network_secret': PropertySchema(
      id: 22,
      name: r'network_secret',
      type: IsarType.string,
    ),
    r'no_tun': PropertySchema(
      id: 23,
      name: r'no_tun',
      type: IsarType.bool,
    ),
    r'peer': PropertySchema(
      id: 24,
      name: r'peer',
      type: IsarType.stringList,
    ),
    r'proxy_forward_by_system': PropertySchema(
      id: 25,
      name: r'proxy_forward_by_system',
      type: IsarType.bool,
    ),
    r'relay_all_peer_rpc': PropertySchema(
      id: 26,
      name: r'relay_all_peer_rpc',
      type: IsarType.bool,
    ),
    r'relay_network_whitelist': PropertySchema(
      id: 27,
      name: r'relay_network_whitelist',
      type: IsarType.string,
    ),
    r'use_smoltcp': PropertySchema(
      id: 28,
      name: r'use_smoltcp',
      type: IsarType.bool,
    )
  },
  estimateSize: _netConfigEstimateSize,
  serialize: _netConfigSerialize,
  deserialize: _netConfigDeserialize,
  deserializeProp: _netConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _netConfigGetId,
  getLinks: _netConfigGetLinks,
  attach: _netConfigAttach,
  version: '3.1.8',
);

int _netConfigEstimateSize(
  NetConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.default_protocol.length * 3;
  bytesCount += 3 + object.dev_name.length * 3;
  bytesCount += 3 + object.hostname.length * 3;
  bytesCount += 3 + object.instance_name.length * 3;
  bytesCount += 3 + object.ipv4.length * 3;
  bytesCount += 3 + object.listeners.length * 3;
  {
    for (var i = 0; i < object.listeners.length; i++) {
      final value = object.listeners[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.netns.length * 3;
  bytesCount += 3 + object.network_name.length * 3;
  bytesCount += 3 + object.network_secret.length * 3;
  bytesCount += 3 + object.peer.length * 3;
  {
    for (var i = 0; i < object.peer.length; i++) {
      final value = object.peer[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.relay_network_whitelist.length * 3;
  return bytesCount;
}

void _netConfigSerialize(
  NetConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.bind_device);
  writer.writeLong(offsets[1], object.data_compress_algo);
  writer.writeString(offsets[2], object.default_protocol);
  writer.writeString(offsets[3], object.dev_name);
  writer.writeBool(offsets[4], object.dhcp);
  writer.writeBool(offsets[5], object.disable_kcp_input);
  writer.writeBool(offsets[6], object.disable_p2p);
  writer.writeBool(offsets[7], object.disable_relay_kcp);
  writer.writeBool(offsets[8], object.disable_udp_hole_punching);
  writer.writeBool(offsets[9], object.enable_encryption);
  writer.writeBool(offsets[10], object.enable_exit_node);
  writer.writeBool(offsets[11], object.enable_ipv6);
  writer.writeBool(offsets[12], object.enable_kcp_proxy);
  writer.writeString(offsets[13], object.hostname);
  writer.writeString(offsets[14], object.instance_name);
  writer.writeString(offsets[15], object.ipv4);
  writer.writeBool(offsets[16], object.latency_first);
  writer.writeStringList(offsets[17], object.listeners);
  writer.writeLong(offsets[18], object.mtu);
  writer.writeBool(offsets[19], object.multi_thread);
  writer.writeString(offsets[20], object.netns);
  writer.writeString(offsets[21], object.network_name);
  writer.writeString(offsets[22], object.network_secret);
  writer.writeBool(offsets[23], object.no_tun);
  writer.writeStringList(offsets[24], object.peer);
  writer.writeBool(offsets[25], object.proxy_forward_by_system);
  writer.writeBool(offsets[26], object.relay_all_peer_rpc);
  writer.writeString(offsets[27], object.relay_network_whitelist);
  writer.writeBool(offsets[28], object.use_smoltcp);
}

NetConfig _netConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NetConfig();
  object.bind_device = reader.readBool(offsets[0]);
  object.data_compress_algo = reader.readLong(offsets[1]);
  object.default_protocol = reader.readString(offsets[2]);
  object.dev_name = reader.readString(offsets[3]);
  object.dhcp = reader.readBool(offsets[4]);
  object.disable_kcp_input = reader.readBool(offsets[5]);
  object.disable_p2p = reader.readBool(offsets[6]);
  object.disable_relay_kcp = reader.readBool(offsets[7]);
  object.disable_udp_hole_punching = reader.readBool(offsets[8]);
  object.enable_encryption = reader.readBool(offsets[9]);
  object.enable_exit_node = reader.readBool(offsets[10]);
  object.enable_ipv6 = reader.readBool(offsets[11]);
  object.enable_kcp_proxy = reader.readBool(offsets[12]);
  object.hostname = reader.readString(offsets[13]);
  object.id = id;
  object.instance_name = reader.readString(offsets[14]);
  object.ipv4 = reader.readString(offsets[15]);
  object.latency_first = reader.readBool(offsets[16]);
  object.listeners = reader.readStringList(offsets[17]) ?? [];
  object.mtu = reader.readLong(offsets[18]);
  object.multi_thread = reader.readBool(offsets[19]);
  object.netns = reader.readString(offsets[20]);
  object.network_name = reader.readString(offsets[21]);
  object.network_secret = reader.readString(offsets[22]);
  object.no_tun = reader.readBool(offsets[23]);
  object.peer = reader.readStringList(offsets[24]) ?? [];
  object.proxy_forward_by_system = reader.readBool(offsets[25]);
  object.relay_all_peer_rpc = reader.readBool(offsets[26]);
  object.relay_network_whitelist = reader.readString(offsets[27]);
  object.use_smoltcp = reader.readBool(offsets[28]);
  return object;
}

P _netConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readStringList(offset) ?? []) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readBool(offset)) as P;
    case 24:
      return (reader.readStringList(offset) ?? []) as P;
    case 25:
      return (reader.readBool(offset)) as P;
    case 26:
      return (reader.readBool(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _netConfigGetId(NetConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _netConfigGetLinks(NetConfig object) {
  return [];
}

void _netConfigAttach(IsarCollection<dynamic> col, Id id, NetConfig object) {
  object.id = id;
}

extension NetConfigQueryWhereSort
    on QueryBuilder<NetConfig, NetConfig, QWhere> {
  QueryBuilder<NetConfig, NetConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NetConfigQueryWhere
    on QueryBuilder<NetConfig, NetConfig, QWhereClause> {
  QueryBuilder<NetConfig, NetConfig, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NetConfigQueryFilter
    on QueryBuilder<NetConfig, NetConfig, QFilterCondition> {
  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> bind_deviceEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bind_device',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      data_compress_algoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data_compress_algo',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      data_compress_algoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'data_compress_algo',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      data_compress_algoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'data_compress_algo',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      data_compress_algoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'data_compress_algo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'default_protocol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'default_protocol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'default_protocol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'default_protocol',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'default_protocol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'default_protocol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'default_protocol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'default_protocol',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'default_protocol',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      default_protocolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'default_protocol',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dev_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dev_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dev_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dev_name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dev_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dev_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dev_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dev_name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dev_nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dev_name',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      dev_nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dev_name',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> dhcpEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dhcp',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      disable_kcp_inputEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'disable_kcp_input',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> disable_p2pEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'disable_p2p',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      disable_relay_kcpEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'disable_relay_kcp',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      disable_udp_hole_punchingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'disable_udp_hole_punching',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      enable_encryptionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enable_encryption',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      enable_exit_nodeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enable_exit_node',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> enable_ipv6EqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enable_ipv6',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      enable_kcp_proxyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enable_kcp_proxy',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hostname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hostname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> hostnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hostname',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      hostnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hostname',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instance_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'instance_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'instance_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'instance_name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'instance_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'instance_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'instance_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'instance_name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instance_name',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      instance_nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'instance_name',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipv4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ipv4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ipv4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ipv4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ipv4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ipv4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ipv4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ipv4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipv4',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> ipv4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ipv4',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      latency_firstEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latency_first',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listeners',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listeners',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listeners',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listeners',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'listeners',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'listeners',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'listeners',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'listeners',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listeners',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'listeners',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeners',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> listenersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeners',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeners',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeners',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeners',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      listenersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeners',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> mtuEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mtu',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> mtuGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mtu',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> mtuLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mtu',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> mtuBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mtu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> multi_threadEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'multi_thread',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'netns',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'netns',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'netns',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'netns',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'netns',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'netns',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'netns',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'netns',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'netns',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> netnsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'netns',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> network_nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'network_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'network_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'network_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> network_nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'network_name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'network_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'network_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'network_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> network_nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'network_name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'network_name',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'network_name',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'network_secret',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'network_secret',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'network_secret',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'network_secret',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'network_secret',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'network_secret',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'network_secret',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'network_secret',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'network_secret',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      network_secretIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'network_secret',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> no_tunEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'no_tun',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      peerElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      peerElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'peer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'peer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'peer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'peer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      peerElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peer',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      peerElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'peer',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'peer',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'peer',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'peer',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'peer',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      peerLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'peer',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> peerLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'peer',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      proxy_forward_by_systemEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proxy_forward_by_system',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_all_peer_rpcEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relay_all_peer_rpc',
        value: value,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relay_network_whitelist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relay_network_whitelist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relay_network_whitelist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relay_network_whitelist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relay_network_whitelist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relay_network_whitelist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relay_network_whitelist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relay_network_whitelist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relay_network_whitelist',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition>
      relay_network_whitelistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relay_network_whitelist',
        value: '',
      ));
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterFilterCondition> use_smoltcpEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'use_smoltcp',
        value: value,
      ));
    });
  }
}

extension NetConfigQueryObject
    on QueryBuilder<NetConfig, NetConfig, QFilterCondition> {}

extension NetConfigQueryLinks
    on QueryBuilder<NetConfig, NetConfig, QFilterCondition> {}

extension NetConfigQuerySortBy on QueryBuilder<NetConfig, NetConfig, QSortBy> {
  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByBind_device() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bind_device', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByBind_deviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bind_device', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByData_compress_algo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data_compress_algo', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByData_compress_algoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data_compress_algo', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDefault_protocol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'default_protocol', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByDefault_protocolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'default_protocol', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDev_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dev_name', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDev_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dev_name', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDhcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhcp', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDhcpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhcp', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDisable_kcp_input() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_kcp_input', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByDisable_kcp_inputDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_kcp_input', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDisable_p2p() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_p2p', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDisable_p2pDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_p2p', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByDisable_relay_kcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_relay_kcp', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByDisable_relay_kcpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_relay_kcp', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByDisable_udp_hole_punching() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_udp_hole_punching', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByDisable_udp_hole_punchingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_udp_hole_punching', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByEnable_encryption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_encryption', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByEnable_encryptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_encryption', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByEnable_exit_node() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_exit_node', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByEnable_exit_nodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_exit_node', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByEnable_ipv6() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_ipv6', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByEnable_ipv6Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_ipv6', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByEnable_kcp_proxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_kcp_proxy', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByEnable_kcp_proxyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_kcp_proxy', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByHostname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByHostnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByInstance_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instance_name', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByInstance_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instance_name', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByIpv4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipv4', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByIpv4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipv4', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByLatency_first() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latency_first', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByLatency_firstDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latency_first', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByMtu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mtu', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByMtuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mtu', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByMulti_thread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multi_thread', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByMulti_threadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multi_thread', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNetns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netns', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNetnsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netns', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNetwork_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_name', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNetwork_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_name', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNetwork_secret() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_secret', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNetwork_secretDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_secret', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNo_tun() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'no_tun', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByNo_tunDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'no_tun', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByProxy_forward_by_system() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proxy_forward_by_system', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByProxy_forward_by_systemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proxy_forward_by_system', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByRelay_all_peer_rpc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_all_peer_rpc', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByRelay_all_peer_rpcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_all_peer_rpc', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByRelay_network_whitelist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_network_whitelist', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      sortByRelay_network_whitelistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_network_whitelist', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByUse_smoltcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'use_smoltcp', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> sortByUse_smoltcpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'use_smoltcp', Sort.desc);
    });
  }
}

extension NetConfigQuerySortThenBy
    on QueryBuilder<NetConfig, NetConfig, QSortThenBy> {
  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByBind_device() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bind_device', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByBind_deviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bind_device', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByData_compress_algo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data_compress_algo', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByData_compress_algoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data_compress_algo', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDefault_protocol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'default_protocol', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByDefault_protocolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'default_protocol', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDev_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dev_name', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDev_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dev_name', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDhcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhcp', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDhcpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhcp', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDisable_kcp_input() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_kcp_input', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByDisable_kcp_inputDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_kcp_input', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDisable_p2p() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_p2p', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDisable_p2pDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_p2p', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByDisable_relay_kcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_relay_kcp', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByDisable_relay_kcpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_relay_kcp', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByDisable_udp_hole_punching() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_udp_hole_punching', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByDisable_udp_hole_punchingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disable_udp_hole_punching', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByEnable_encryption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_encryption', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByEnable_encryptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_encryption', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByEnable_exit_node() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_exit_node', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByEnable_exit_nodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_exit_node', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByEnable_ipv6() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_ipv6', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByEnable_ipv6Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_ipv6', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByEnable_kcp_proxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_kcp_proxy', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByEnable_kcp_proxyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable_kcp_proxy', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByHostname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByHostnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByInstance_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instance_name', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByInstance_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instance_name', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByIpv4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipv4', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByIpv4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipv4', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByLatency_first() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latency_first', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByLatency_firstDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latency_first', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByMtu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mtu', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByMtuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mtu', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByMulti_thread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multi_thread', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByMulti_threadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'multi_thread', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNetns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netns', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNetnsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netns', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNetwork_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_name', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNetwork_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_name', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNetwork_secret() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_secret', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNetwork_secretDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network_secret', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNo_tun() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'no_tun', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByNo_tunDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'no_tun', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByProxy_forward_by_system() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proxy_forward_by_system', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByProxy_forward_by_systemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proxy_forward_by_system', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByRelay_all_peer_rpc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_all_peer_rpc', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByRelay_all_peer_rpcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_all_peer_rpc', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByRelay_network_whitelist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_network_whitelist', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy>
      thenByRelay_network_whitelistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relay_network_whitelist', Sort.desc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByUse_smoltcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'use_smoltcp', Sort.asc);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QAfterSortBy> thenByUse_smoltcpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'use_smoltcp', Sort.desc);
    });
  }
}

extension NetConfigQueryWhereDistinct
    on QueryBuilder<NetConfig, NetConfig, QDistinct> {
  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByBind_device() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bind_device');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByData_compress_algo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data_compress_algo');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByDefault_protocol(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'default_protocol',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByDev_name(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dev_name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByDhcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dhcp');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByDisable_kcp_input() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'disable_kcp_input');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByDisable_p2p() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'disable_p2p');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByDisable_relay_kcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'disable_relay_kcp');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct>
      distinctByDisable_udp_hole_punching() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'disable_udp_hole_punching');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByEnable_encryption() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enable_encryption');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByEnable_exit_node() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enable_exit_node');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByEnable_ipv6() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enable_ipv6');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByEnable_kcp_proxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enable_kcp_proxy');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByHostname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hostname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByInstance_name(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instance_name',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByIpv4(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ipv4', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByLatency_first() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latency_first');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByListeners() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listeners');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByMtu() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mtu');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByMulti_thread() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'multi_thread');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByNetns(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'netns', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByNetwork_name(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'network_name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByNetwork_secret(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'network_secret',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByNo_tun() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'no_tun');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByPeer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peer');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct>
      distinctByProxy_forward_by_system() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proxy_forward_by_system');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByRelay_all_peer_rpc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relay_all_peer_rpc');
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct>
      distinctByRelay_network_whitelist({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relay_network_whitelist',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetConfig, NetConfig, QDistinct> distinctByUse_smoltcp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'use_smoltcp');
    });
  }
}

extension NetConfigQueryProperty
    on QueryBuilder<NetConfig, NetConfig, QQueryProperty> {
  QueryBuilder<NetConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> bind_deviceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bind_device');
    });
  }

  QueryBuilder<NetConfig, int, QQueryOperations> data_compress_algoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data_compress_algo');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> default_protocolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'default_protocol');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> dev_nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dev_name');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> dhcpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dhcp');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> disable_kcp_inputProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'disable_kcp_input');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> disable_p2pProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'disable_p2p');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> disable_relay_kcpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'disable_relay_kcp');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations>
      disable_udp_hole_punchingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'disable_udp_hole_punching');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> enable_encryptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enable_encryption');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> enable_exit_nodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enable_exit_node');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> enable_ipv6Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enable_ipv6');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> enable_kcp_proxyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enable_kcp_proxy');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> hostnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hostname');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> instance_nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instance_name');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> ipv4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ipv4');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> latency_firstProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latency_first');
    });
  }

  QueryBuilder<NetConfig, List<String>, QQueryOperations> listenersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listeners');
    });
  }

  QueryBuilder<NetConfig, int, QQueryOperations> mtuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mtu');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> multi_threadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'multi_thread');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> netnsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'netns');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> network_nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'network_name');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations> network_secretProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'network_secret');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> no_tunProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'no_tun');
    });
  }

  QueryBuilder<NetConfig, List<String>, QQueryOperations> peerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peer');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations>
      proxy_forward_by_systemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proxy_forward_by_system');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> relay_all_peer_rpcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relay_all_peer_rpc');
    });
  }

  QueryBuilder<NetConfig, String, QQueryOperations>
      relay_network_whitelistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relay_network_whitelist');
    });
  }

  QueryBuilder<NetConfig, bool, QQueryOperations> use_smoltcpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'use_smoltcp');
    });
  }
}
