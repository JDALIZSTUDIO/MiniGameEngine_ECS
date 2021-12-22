return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "left-up",
  width = 17,
  height = 7,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 5,
  nextobjectid = 27,
  properties = {},
  tilesets = {
    {
      name = "New_Environment",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "../Images/New_Environment.png",
      imagewidth = 256,
      imageheight = 256,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {
        {
          name = "terrain1",
          tile = -1,
          properties = {},
          colors = {
            {
              color = { 255, 0, 0 },
              name = "walls",
              probability = 1,
              tile = -1,
              properties = {}
            },
            {
              color = { 0, 255, 0 },
              name = "grass",
              probability = 1,
              tile = -1,
              properties = {}
            }
          },
          wangtiles = {
            {
              wangid = { 0, 0, 0, 1, 0, 0, 0, 0 },
              tileid = 1
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 2
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 0 },
              tileid = 3
            },
            {
              wangid = { 0, 1, 0, 0, 0, 1, 0, 1 },
              tileid = 4
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 5
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 1 },
              tileid = 6
            },
            {
              wangid = { 0, 0, 0, 2, 0, 0, 0, 0 },
              tileid = 8
            },
            {
              wangid = { 0, 0, 0, 2, 0, 2, 0, 0 },
              tileid = 9
            },
            {
              wangid = { 0, 0, 0, 0, 0, 2, 0, 0 },
              tileid = 10
            },
            {
              wangid = { 0, 2, 0, 0, 0, 2, 0, 2 },
              tileid = 11
            },
            {
              wangid = { 0, 2, 0, 0, 0, 0, 0, 2 },
              tileid = 12
            },
            {
              wangid = { 0, 2, 0, 2, 0, 0, 0, 2 },
              tileid = 13
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 17
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 1 },
              tileid = 18
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 19
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 20
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 22
            },
            {
              wangid = { 0, 2, 0, 2, 0, 0, 0, 0 },
              tileid = 24
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 2 },
              tileid = 25
            },
            {
              wangid = { 0, 0, 0, 0, 0, 2, 0, 2 },
              tileid = 26
            },
            {
              wangid = { 0, 0, 0, 0, 0, 2, 0, 2 },
              tileid = 27
            },
            {
              wangid = { 0, 2, 0, 2, 0, 0, 0, 0 },
              tileid = 29
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 0 },
              tileid = 33
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 34
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 1 },
              tileid = 35
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 1 },
              tileid = 36
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 37
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 0 },
              tileid = 38
            },
            {
              wangid = { 0, 2, 0, 0, 0, 0, 0, 0 },
              tileid = 40
            },
            {
              wangid = { 0, 2, 0, 0, 0, 0, 0, 2 },
              tileid = 41
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 2 },
              tileid = 42
            },
            {
              wangid = { 0, 0, 0, 2, 0, 2, 0, 2 },
              tileid = 43
            },
            {
              wangid = { 0, 0, 0, 2, 0, 2, 0, 0 },
              tileid = 44
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 0 },
              tileid = 45
            }
          }
        }
      },
      tilecount = 256,
      tiles = {
        {
          id = 129,
          animation = {
            {
              tileid = 129,
              duration = 100
            },
            {
              tileid = 130,
              duration = 100
            },
            {
              tileid = 131,
              duration = 100
            },
            {
              tileid = 132,
              duration = 100
            }
          }
        }
      }
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
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 47, 26,
        26, 15, 26, 26, 26, 26, 26, 16, 26, 26, 26, 26, 48, 26, 26, 26, 26,
        26, 26, 26, 32, 26, 26, 26, 26, 26, 32, 26, 26, 26, 26, 32, 26, 26,
        26, 47, 26, 26, 26, 26, 15, 26, 26, 26, 26, 26, 16, 26, 26, 26, 26,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 31, 26, 26, 26,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26
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
        19, 19, 19, 19, 5, 35, 35, 6, 6, 6, 35, 35, 35, 35, 6, 6, 7,
        5, 35, 6, 6, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
        20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23,
        21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
        20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
        37, 3, 3, 38, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
        19, 19, 19, 19, 37, 38, 38, 38, 3, 3, 3, 38, 3, 3, 3, 38, 39
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
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
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
          id = 1,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 48,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 162,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 162,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 162,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 162,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 162,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 48,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 162,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 166,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "bush",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 228,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "bush",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 228,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 256,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "spawner",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 254,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "barrel",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 252,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "barrel",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 252,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "crate",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 250,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
