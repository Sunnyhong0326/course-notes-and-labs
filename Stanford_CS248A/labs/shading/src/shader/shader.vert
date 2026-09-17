uniform mat4 obj2world;                 // object to world transform
uniform mat3 obj2worldNorm;             // object to world transform for normals
uniform vec3 camera_position;           // world space camera position           

uniform mat4 mvp;                       // model-view-projection matrix

uniform bool useNormalMapping;         // true if normal mapping should be used

// per vertex input attributes 
in vec3 vtx_position;            // object space position
in vec3 vtx_tangent;
in vec3 vtx_normal;              // object space normal
in vec2 vtx_texcoord;
in vec3 vtx_diffuse_color; 

// per vertex outputs 
out vec3 position;                  // world space position
out vec3 vertex_diffuse_color;
out vec2 texcoord;
out vec3 dir2camera;                // world space vector from surface point to camera
out vec3 normal;
out vec3 worldTangent;
// out mat3 tan2world;                 // tangent space rotation matrix multiplied by obj2WorldNorm

void main(void)
{
    position = vec3(obj2world * vec4(vtx_position, 1));

    worldTangent = normalize(obj2worldNorm * vtx_tangent);
    
    normal = obj2worldNorm * vtx_normal;

    vertex_diffuse_color = vtx_diffuse_color;
    texcoord = vtx_texcoord;
    dir2camera = camera_position - position;
    gl_Position = mvp * vec4(vtx_position, 1);
}
