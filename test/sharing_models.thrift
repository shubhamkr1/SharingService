/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */

 namespace java org.apache.airavata.sharing.registry.models

const string DO_NOT_SET_AT_CLIENTS_ID = "DO_NOT_SET_AT_CLIENTS_ID"

/**
* <p>Domain is the entity that enables multi-tenency in this componenet. Every tenant will be
* operating separately it's own silo which is identified by the domain id. In the current implementation domain id
* will be same as the domain name</p>
* <li>domainId : Will be generated by the server based on the domain name</li>
* <li><b>name</b> : A single word name that identifies the domain e.g seagrid, ultrascan</li>
* <li>description : A short description for the domain</li>
* <li>createdTime : Will be set by the system</li>
* <li>updatedTime : Will be set by the system</li>
**/
struct Domain {
    1: optional string domainId = DO_NOT_SET_AT_CLIENTS_ID,
    2: optional string name,
    3: optional string description,
    4: optional i64 createdTime,
    5: optional i64 updatedTime
}

/**
* <p>User is the model used to register a user in the system. Minimal user information will be required to provide
* regarding the user.</p>
* <li><b>userId</b> : User id provided by the client</li>
* <li><b>domainId</b> : Domain id for that user</li>
* <li><b>userName</b> : User name for the user</li>
* <li><b>firstName</b> : First name of the user</li>
* <li><b>lastName</b> : Last name of the user</li>
* <li><b>email</b> : Email address of the user</li>
* <li>icon : A binary field for storing the user icon</li>
* <li>createdTime : If client provides this value then the system will use it if not the current time will be set</li>
* <li>updatedTime : If client provides this value then the system will use it if not the current time will be set</li>
**/
struct User {
 1: optional string userId,
 2: optional string domainId,
 3: optional string userName,
 4: optional string firstName,
 5: optional string lastName,
 6: optional string email,
 7: optional binary icon,
 8: optional i64 createdTime,
 9: optional i64 updatedTime
}

/**
* <p>This is an system internal enum used to define single user groups and multi users groups. Every user is also
* considered as a group in it's own right for implementation ease</p>
**/
enum GroupCardinality {
    SINGLE_USER,
    MULTI_USER
}

/**
* <p>Group types can be either user level or domain level groups.</p>
**/
enum GroupType {
    DOMAIN_LEVEL_GROUP,
    USER_LEVEL_GROUP
}

/**
* <p>Group Visibility can be either private or public.</p>
**/
enum GroupVisibility {
    PRIVATE,
    PUBLIC
}

/**
*<p>User group is a collection of users.</p>
* <li><b>groupId</b> : Group id provided by the client</li>
* <li><b>domainId</b> : Domain id for this user group</li>
* <li><b>name</b> : Name for the user group. should be one word</li>
* <li>description : Short description for the group.</li>
* <li><b>ownerId</b> : Owner id of this group.</li>
* <li><b>groupType</b> : Group type (DOMAIN_LEVEL_GROUP, USER_LEVEL_GROUP)</li>
* <li><b>groupCardinality</b> : Group cardinality (SINGLE_USER, MULTI_USER)</li>
* <li>createdTime : Will be set by the system</li>
* <li>updatedTime : Will be set by the system</li>
**/
struct UserGroup {
 1: optional string groupId,
 2: optional string domainId,
 3: optional string name,
 4: optional string description,
 5: optional string ownerId,
 6: optional GroupType groupType,
 7: optional GroupCardinality groupCardinality,
 8: optional i64 createdTime,
 9: optional i64 updatedTime,
 10: optional GroupVisibility groupVisibility
}

/**
* <p>System internal data type to match group child types</p>
**/
enum GroupChildType {
    USER,
    GROUP
}

/**
* <p>System internal data type to map group memberships</p>
**/
struct GroupMembership {
    1: optional string parentId,
    2: optional string childId,
    3: optional string domainId,
    4: optional GroupChildType childType
    5: optional i64 createdTime,
    6: optional i64 updatedTime
}


/**
* <p>client defined entity types</p>
* <li><b>entityTypeId</b> : Entity type id provided by the client</li>
* <li><b>domainId</b> : Domain id of the domain.</li>
* <li><b>name</b> : Name for the entity type. Should be a single word.</li>
* <li>description : Short description for the entity type.</li>
* <li>createdTime : Will be set by the system</li>
* <li>updatedTime : Will be set by the system</li>
**/
struct EntityType {
    1: optional string entityTypeId,
    2: optional string domainId,
    3: optional string name,
    4: optional string description,
    5: optional i64 createdTime,
    6: optional i64 updatedTime
}

/**
* <p>This list of fields that can be used to search entities</p>
* <li>NAME : Name of the entity</li>
* <li>DESCRIPTION : Description of the entity</li>
* <li>FULL_TEXT : Full text field of the entity</li>
* <li>PARENT_ENTITY_ID : Parent entity id of the entity</li>
* <li>OWNER_ID : Owner of the entity</li>
* <li>CREATED_TIME : Created time of the entity</li>
* <li>UPDATED_TIME : Updated time of the entity</li>
* <li>SHARED_COUNT : Number of directly shared users and groups</li>
**/
enum EntitySearchField {
    NAME,
    DESCRIPTION,
    FULL_TEXT,
    PARRENT_ENTITY_ID,
    OWNER_ID,
    PERMISSION_TYPE_ID,
    CREATED_TIME,
    UPDATED_TIME,
    ENTITY_TYPE_ID,
    SHARED_COUNT
}

/**
* <p>Different search operators that can be used with the entity search fields</p>
* <li>EQUAL : Simply matches for equality. Applicable for name, and parent entity id</li>
* <li>LIKE : Check for the condition %$FIELD% condition. Applicable for name, and description</li>
* <li>FULL_TEXT : Does a full text search. Only applicable for the FULL_TEXT field.</li>
* <li>GTE : Greater than or equal. Only applicable for created time, updated time and shared count.</li>
* <li>LTE : Less than or equal. Only applicable for created time, updated time and shared count.</li>
**/
enum SearchCondition {
    EQUAL,
    LIKE,
    FULL_TEXT,
    GTE,
    LTE,
    NOT
}

/**
* <p>Container object for search criteria</p>
* <li><b>searchField</b> : Entity search field</li>
* <li><b>value</b> : Search value</li>
* <li><b>searchCondition</b> : EQUAL, LIKE etc..</li>
**/
struct SearchCriteria {
    1: optional EntitySearchField searchField,
    2: optional string value,
    3: optional SearchCondition searchCondition
}

/**
* <p>Entity object which is used to register an entity in the system.</p>
* <li><b>entityId</b> : Entity id provided by the client</li>
* <li><b>domainId</b> : Domain id</li>
* <li><b>entityTypeId</b> : Entity type id</li>
* <li><b>ownerId</b> : Owner id</li>
* <li>parentEntityId : Parent entity id</li>
* <li><b>name</b> : Name</li>
* <li>description : Short description for the entity</li>
* <li>binaryData : Any information stored in binary format</li>
* <li>fullText : A string which will be considered for full text search</li>
* <li><b>originalEntityCreationTime</b> : When registering old records what is the original entity creation time. If not
* set will be default to current time</li>
* <li>createdTime : Will be set by the system</li>
* <li>updatedTime : Will be set by the system</li>
**/
struct Entity {
    1: optional string entityId,
    2: optional string domainId,
    3: optional string entityTypeId,
    4: optional string ownerId,
    5: optional string parentEntityId,
    6: optional string name,
    7: optional string description,
    8: optional binary binaryData,
    9: optional string fullText,
    10: optional i64 sharedCount = 0,
    11: optional i64 originalEntityCreationTime,
    12: optional i64 createdTime,
    13: optional i64 updatedTime
}

/**
* <p>Object for creating client defined permission type</p>
* <li><b>permissionTypeId</b> : Permission type id provided by the client</li>
* <li><b>domainId</b> : Domain id</li>
* <li><b>name</b> : Single word name for the permission</li>
* <li>description : Short description for the permission type</li>
* <li>createdTime : Will be set by the system</li>
* <li>updatedTime : Will be set by the system</li>
**/
struct PermissionType {
    1: optional string permissionTypeId,
    2: optional string domainId,
    3: optional string name,
    4: optional string description,
    5: optional i64 createdTime,
    6: optional i64 updatedTime
}

/**
* <p>This is an internal enum type for managing sharings</p>
**/
enum SharingType {
    DIRECT_NON_CASCADING,
    DIRECT_CASCADING,
    INDIRECT_CASCADING
 }

/**
* <p>This is an internal enum type for managing sharings</p>
**/
struct Sharing {
    1: optional string permissionTypeId,
    2: optional string entityId,
    3: optional string groupId,
    4: optional SharingType sharingType,
    5: optional string domainId,
    6: optional string inheritedParentId,
    7: optional i64 createdTime,
    8: optional i64 updatedTime
}

/**
* <p>Exception model used in the sharing registry service</p>
**/
exception SharingRegistryException {
  1: required string message
}

/**
* This exception is thrown when you try to save a duplicate entity that already exists
*   in the database.
*
*   message: contains the associated error message
**/
exception DuplicateEntryException {
    1: required string message
}