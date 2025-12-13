import { useBackend } from 'tgui/backend';
import { Box, Section, ProgressBar, Button, Stack, NoticeBox } from 'tgui-core/components';

interface GeoCoolingManifoldData {
  coolant_temp: number;
  housing_temp: number;
  coolant_flow: number;
  flow_instability: boolean;
  max_coolant_temp: number;
  max_housing_temp: number;
  max_coolant_flow: number;
}

export const GeoCoolingManifold = () => {
  const { act, data } = useBackend<GeoCoolingManifoldData>();

  const { coolant_temp, housing_temp, coolant_flow, flow_instability,
          max_coolant_temp, max_housing_temp, max_coolant_flow } = data;

  const adjustSteps = [-10, -5, -1, +1, +5, +10];

  const barColor = (pct: number) => {
    if (pct < 50) return 'good';
    if (pct < 80) return 'average';
    return 'bad';
  };

  return (
    <Box>
      <Section title="Cooling Manifold Control">
        <Stack vertical>
          <Stack.Item>
            <b>Coolant Temp:</b> {coolant_temp} K
            <ProgressBar
              value={(coolant_temp / max_coolant_temp) * 100}
              color={barColor((coolant_temp / max_coolant_temp) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Housing Temp:</b> {housing_temp} K
            <ProgressBar
              value={(housing_temp / max_housing_temp) * 100}
              color={barColor((housing_temp / max_housing_temp) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Coolant Flow:</b> {coolant_flow} L/s
            <ProgressBar
              value={(coolant_flow / max_coolant_flow) * 100}
              color={barColor((coolant_flow / max_coolant_flow) * 100)}
            />
            <Box textAlign="center">
              {adjustSteps.map((n) => (
                <Button key={n} onClick={() => act('adjust_flow', { amount: n })}>
                  {n > 0 ? `+${n}` : n}
                </Button>
              ))}
            </Box>
          </Stack.Item>

          {flow_instability && (
            <NoticeBox color="bad">
              Warning: Flow instability detected!
            </NoticeBox>
          )}
        </Stack>
      </Section>
    </Box>
  );
};
