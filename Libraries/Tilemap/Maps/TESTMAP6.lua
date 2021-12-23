return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "left-up",
  width = 17,
  height = 7,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 5,
  nextobjectid = 17,
  properties = {},
  tilesets = {
    {
      name = "newTerrain32x32",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "../Images/newTerrain32x32.png",
      imagewidth = 512,
      imageheight = 512,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {
        {
          name = "terrain",
          tile = -1,
          properties = {},
          colors = {
            {
              color = { 255, 0, 0 },
              name = "walls",
              probability = 1,
              tile = -1,
              properties = {}
            }
          },
          wangtiles = {
            {
              wangid = { 0, 0, 0, 1, 0, 0, 0, 0 },
              tileid = 0
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 1
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 0 },
              tileid = 2
            },
            {
              wangid = { 0, 1, 0, 0, 0, 1, 0, 1 },
              tileid = 3
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 4
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 1 },
              tileid = 5
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 16
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 18
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 19
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 21
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 0 },
              tileid = 32
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 33
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 1 },
              tileid = 34
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 1 },
              tileid = 35
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 36
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 0 },
              tileid = 37
            }
          }
        }
      },
      tilecount = 256,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 17,
      height = 7,
      id = 1,
      name = "ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["Depth"] = 0
      },
      encoding = "lua",
      data = {
        49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49,
        49, 49, 49, 49, 49, 49, 49, 49, 98, 49, 49, 49, 49, 49, 49, 49, 49,
        49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 67, 65, 49,
        49, 49, 49, 66, 49, 49, 49, 49, 49, 49, 81, 49, 66, 49, 49, 49, 49,
        49, 49, 49, 49, 49, 49, 49, 82, 49, 49, 49, 49, 49, 49, 49, 49, 49,
        49, 49, 49, 49, 49, 49, 97, 49, 49, 49, 49, 49, 49, 83, 49, 49, 49,
        49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 17,
      height = 7,
      id = 2,
      name = "walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["Depth"] = 0
      },
      encoding = "lua",
      data = {
        18, 18, 18, 18, 4, 34, 34, 5, 5, 34, 34, 5, 5, 5, 34, 34, 6,
        4, 34, 34, 34, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22,
        20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17,
        19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22,
        19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22,
        36, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17,
        18, 18, 18, 18, 36, 2, 2, 37, 2, 2, 37, 37, 37, 2, 37, 37, 38
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 17,
      height = 7,
      id = 4,
      name = "collisions",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["Depth"] = 0,
        ["Solid"] = true
      },
      encoding = "lua",
      data = {
        241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241,
        241, 241, 241, 241, 241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 241, 241, 241, 241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 1,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 242,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
